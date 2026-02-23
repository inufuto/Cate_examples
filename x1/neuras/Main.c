#include "Main.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Solver.h"
#include "Card.h"
#include "Monster.h"

#include "Status.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Sync.h"

extern void Init();
extern void Fin();
// extern void WaitTimer(byte t);

word Score;
word HiScore;
byte RemainSolverCount;

constexpr byte TimeRate = 100;
static byte TimeCount;

constexpr byte BonusRate = 3;

void Main()
{
    ClearScreen();
    byte key;
    Init(); 
    InitSprites();
    
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainSolverCount = 3;
    StageTime = 0;
    pHeldCard = nullptr;
title:;
    Title();
    do {
        if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
    ClearScreen();
play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainSolverCount = 3;

    while (true) {
        byte clock;
        // sbyte s;
        // s = 0;

        InitStage();

        try :
        InitTrying(); 
        PrintStatus();
        VVramToVram();
        // UpdateSprites();
        Sound_Start();
        TimeCount = TimeRate;
        clock = 0;
        StartBGM();

        do {
            if (ScanStop()) goto exit;
            MoveSolver();
            MoveCard();
            MoveMonsters();
            { 
                if (clock == 0) {
                    EraseSprites();
                    DrawSprites();
                    VVramToVram();
                    //RotateSprites();
                    //UpdateSprites();
                    clock = 4;
                }
                --clock;
            }

            if (SolverStatus == Solver_Status_Die) {
                StopBGM();
                EndSolver();
                lose:
                --RemainSolverCount;
                if (RemainSolverCount != 0)  goto try;
                PrintGameOver();
                Sound_GameOver();
                goto title;
            }

            WaitVSyncOut();
            SoundHandler();
            WaitVSyncIn();

            --TimeCount;
            if (TimeCount == 0) {
                --StageTime;
                TimeCount = TimeRate;
                PrintTime();
                if (StageTime == 0) {
                    StopBGM();
                    PrintTimeUp();
                    repeat (15) {
                        Sound_Loose();
                    }
                    goto lose;
                }
            }
            // if (s < 0) {
            //     WaitTimer(1);
            //     s += 2;
            // }   
            // else {
            //     s -= 3;
            // }
        } while (RemainCardCount != 0);
        StopBGM();
        Sound_Clear();
        while (StageTime >= BonusRate) {
            AddScore(1);
            StageTime -= BonusRate;
            PrintStatus();
            Sound_Get();
            repeat(255);
        }
        StageTime = 0;
        PrintStatus();
        ++CurrentStage;
    };
exit:
    Fin();
}


void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}