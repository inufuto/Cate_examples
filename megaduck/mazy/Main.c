#include "Main.h"
#include "ScanKeys.h"
#include "Man.h"
#include "Knife.h"
#include "Monster.h"
#include "Status.h"
#include "Vram.h"
#include "Sound.h"
#include "Map.h"
#include "Sound.h"

extern void WaitTimer(byte t);

word Score;
byte RemainCount;
byte TimeRate;
byte CurrentStage;
word StageTime;
bool StageClear;

static byte clock;

static byte TimeCount;
// extern byte PrevKey;

constexpr byte BonusRate = 3;

void Main()
{
    byte key;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    HeldKnifeCount = 0;
title:
    Title();
    do {
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

// StartGame
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;

    while (true) {
        try:
        ClearScreen();
        ManLost = false;
        clock = 0;
        BaseX = 0;
        BaseY = 0;
        StageClear = false;
        InitMap();
        PrintStatus();
        DrawAll();
        Sound_Start();
        StartBGM();
        do {
            MoveKnives();
            MoveMan();
            MoveMonsters();
            MoveKnives();

            DrawAll();
            ++clock;
            if (clock >= TimeRate) {
                clock = 0;
                --StageTime;
                PrintTime();
                if (StageTime == 0) {
                    StopBGM();
                    PrintTimeUp();
                    repeat (15) {
                        Sound_Loose();
                        // CallSound();
                    }
                    goto lose;
                }
            }

            if (ManLost) {
                StopBGM();
                EndMan();
                lose:
                --RemainCount;
                if (RemainCount != 0)  goto try;
                PrintGameOver();
                Sound_GameOver();
                goto title;
            }
        } while (!StageClear);
        StopBGM();
        DrawMan();
        Sound_Clear();
        while (StageTime != 0) {
            AddScore(1);
            --StageTime;
            PrintTime();
            Sound_Beep();
            // PresendVram();
            // CallSound();
            WaitTimer(2);
        }
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


void DrawAll()
{
    MapToVram();
    DrawGoal();
    DrawMan();
    DrawMonsters();
    DrawKnives();
    SwitchPage();
    WaitTimer(6);
}
