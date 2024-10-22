#include "Main.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Status.h"
#include "Stage.h"
#include "Man.h"
#include "Chaser.h"
#include "Ghost.h"
#include "Rock.h"
#include "Point.h"
#include "Box.h"

extern void WaitTimer(byte t);

constexpr byte MaxTimeDenom = 50;
constexpr byte BonusRate = 3;

word Score;
// word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;
sbyte monsterNum;

extern void ShowStage();

void Main()
{
    byte key, timeDenom;

    // HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    
    title:
    Title();
    do {
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
    
    play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    stage:
    InitStage();   
    try:
    Clock = 0;
    monsterNum = 0;
    timeDenom = MaxTimeDenom;
    InitTrying();
    UpdateSprites();
    Sound_Start();     
    ShowStage();
    WaitSound();
    StartBGM();
    do {
    //     if (ScanStop()) goto exit;
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
            TestRocks();
            WaitTimer(2);
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    StopBGM();
                    PrintTimeUp();
                    LooseMan();
                    goto lose;
                }
            }
            if (monsterNum >= 0) {
                MoveChasers();
                MoveGhosts();
                monsterNum -= 4;
            }
            monsterNum += 3;
        }
        MoveRocks();
        UpdateSprites();
        ++Clock;
        if ((man.status & Movable_Status_Live) == 0) {
            StopBGM();
            LooseMan();
            lose:
            --RemainCount;
            if (RemainCount > 0) {
                goto try;
            } 
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
    } while (BoxCount != 0);
    StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(3);
        StageTime -= BonusRate;
        PrintTime();
        Sound_Beep();
    }
    StageTime = 0;
    PrintStatus();
    ++CurrentStage;
    goto stage;
}


void AddScore(word pts) 
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
}


static void ShowAll()
{
    UpdateSprites();
    WaitTimer(4);
}

void ShowStage()
{
    byte x;
    x = HScroll;
    while (HScroll < 32) {
        ++HScroll;
        ShowAll();
    }
    while (HScroll > 0) {
        --HScroll;
        ShowAll();
    }
    while (HScroll < x) {
        ++HScroll;
        ShowAll();
    }
}


void _deb(){}