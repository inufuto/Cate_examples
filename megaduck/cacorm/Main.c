#include "Main.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Sound.h"
#include "Status.h"
#include "Movable.h"
#include "Actor.h"
#include "Stage.h"
#include "Sprite.h"
#include "Man.h"
#include "Monster.h"
#include "Item.h"
#include "Point.h"

extern void _deb();

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 8;
constexpr byte FireInterval = CoordRate * 12;

word Score;
// word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
static byte Clock;
static sbyte monsterNum;

extern void WaitTimer(byte t);
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
    if ((key & (Keys_Button1 | Keys_Dir)) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    stage:
    InitStage();
    try:
    InitTrying();
    Clock = 0;
    monsterNum = 0;
    timeDenom = MaxTimeDenom;
    Sound_Start();
    ShowStage();
    WaitSound();
    StartBGM();
    do {
        //     if (ScanStop()) goto exit;
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
            WaitTimer(1);
            if (monsterNum >= 0) {
                MoveMonsters();
                monsterNum -= 10;
            }
            monsterNum += 6;
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    PrintTimeUp();
                    lose:
                    StopBGM();
                    LooseMan();
                    --RemainCount;
                    if (RemainCount > 0) {
                        goto try;
                    } 
                    PrintGameOver();
                    Sound_GameOver();
                    goto title;
                }
            }
        }
        if ((Clock & 7) == 0) {
            WaitTimer(1);
        }
        UpdateSprites();
        ++Clock;
        if ((Man.status & Actor_Live) == 0) {
            goto lose;
        }
    } while (ItemCount != 0);
    // ShowMan();
    UpdateSprites();
    StopBGM();
    WaitTimer(10);
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(5);
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