#include "Stage.h"
#include "ScanKeys.h"
#include "Solver.h"
#include "Card.h"
#include "Monster.h"
#include "Status.h"

#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

extern void Init();
// extern void Fin();
extern void WaitTimer(byte t);

word Score;
word HiScore;
byte RemainSolverCount;

constexpr byte TimeRate = 100;
static byte TimeCount;

constexpr byte BonusRate = 3;

void Main()
{
    byte key;

    Init(); 
    InitSprites();
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainSolverCount = 3;
    StageTime = 0;
    pHeldCard = nullptr;
title:
    Title();
    do {
        // if (ScanStop()) goto exit;
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

        InitStage();

        try :
        InitTrying();        
        PrintStatus();
        VVramToVramAll();
        Sound_Start();
        TimeCount = TimeRate;
        StartBGM();

        do {
            // if (ScanStop()) goto exit;
            MoveSolver();
            MoveCard();
            MoveMonsters();

            EraseSprites();
            DrawSprites();
            if ((clock & 1) == 0) {
                WaitTimer(2);
                VVramToVramChanged();
            }
            ++clock;

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
            // WaitTimer(1);
        } while (RemainCardCount != 0);
        StopBGM();
        Sound_Clear();
        while (StageTime >= BonusRate) {
            ++Score;
            StageTime -= BonusRate;
            PrintStatus();
            Sound_Get();
        }
        StageTime = 0;
        PrintStatus();
        ++CurrentStage;
    };
// exit:
//     Fin();
}


void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}