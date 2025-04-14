#include "Main.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Solver.h"
#include "Card.h"
#include "Monster.h"
#include "Status.h"
#include "Sprite.h"
#include "Vram.h"
// #include "Sound.h"
#include "VVram.h"

word Score;
byte RemainCount;

constexpr byte TimeRate = 100;
static byte TimeCount;

constexpr byte BonusRate = 3;

void Main()
{
    byte key;

    // Init(); 
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    pHeldCard = nullptr;
title:
    Title();
    do {
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
    // ClearScreen();
play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;

    while (true) {
        byte clock;

        InitStage();

        try :
        ClearScreen();
        InitTrying();        
        PrintStatus();
        DrawAll();
        // Sound_Start();
        Wait(100);
        TimeCount = TimeRate;
        // StartBGM();
        do {
            // if (ScanStop()) goto exit;
            MoveSolver();
            MoveCard();
            MoveMonsters();

            if ((clock & 1) == 0) {
                DrawAll();
                Wait(1);
            }
            ++clock;

            if (SolverStatus == Solver_Status_Die) {
                // StopBGM();
                EndSolver();
                lose:
                --RemainCount;
                if (RemainCount != 0)  goto try;
                PrintGameOver();
                // PresendVram();
                // Sound_GameOver();
                Wait(200);
                goto title;
            }

            --TimeCount;
            if (TimeCount == 0) {
                --StageTime;
                TimeCount = TimeRate;
                PrintTime();
                if (StageTime == 0) {
                    // StopBGM();
                    PrintTimeUp();
                    // PresendVram();
                    // repeat (15) {
                    //     Sound_Loose();
                    // }
                    Wait(100);
                    goto lose;
                }
            }
            // Wait(1);
        } while (RemainCardCount != 0);
        // StopBGM();
        // Sound_Clear();
        Wait(150);
        while (StageTime >= BonusRate) {
            ++Score;
            StageTime -= BonusRate;
            PrintStatus();
            // Sound_Get();
            Wait(3);
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
    PrintScore();
}

void _deb(){}
