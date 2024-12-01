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

    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainSolverCount = 3;
    StageTime = 0;
    pHeldCard = nullptr;
title:
    Title();
    do {
        if (ScanStop()) return;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainSolverCount = 3;

    while (true) {
        sbyte s;
        s = 0;

        InitStage();

        try :
        ClearScreen();
        InitTrying();        
        PrintStatus();
        // VVramToVram();
        // UpdateSprites();
        DrawAll();
        Sound_Start();
        TimeCount = TimeRate;
        StartBGM();

        do {
            if (ScanStop()) return;
            MoveSolver();
            MoveCard();
            MoveMonsters();
            // EraseSprites();
            // DrawSprites();
            // VVramToVram();
            // RotateSprites();
            // UpdateSprites();

            if (SolverStatus == Solver_Status_Die) {
                StopBGM();
                EndSolver();
                lose:
                --RemainSolverCount;
                if (RemainSolverCount != 0)  goto try;
                PrintGameOver();
                DrawAll();
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
                    DrawAll();
                    repeat (15) {
                        Sound_Loose();
                    }
                    goto lose;
                }
            }
            if (s < 0) {
                DrawAll();
                WaitTimer(2);
                s += 4;
            }   
            else {
                s -= 3;
            }
        } while (RemainCardCount != 0);
        StopBGM();
        DrawAll();
        Sound_Clear();
        while (StageTime >= BonusRate) {
            AddScore(1);
            StageTime -= BonusRate;
            PrintStatus();
            DrawAll();
            Sound_Get();
        }
        StageTime = 0;
        PrintStatus();
        ++CurrentStage;
    };
}


void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}