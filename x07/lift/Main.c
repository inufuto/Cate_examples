#include "Main.h"
#include "ScanKeys.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Status.h"
#include "Stage.h"
#include "Actor.h"
#include "Monster.h"
#include "Lift.h"
#include "Man.h"
#include "Item.h"
#include "Point.h"

extern void _deb();

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 5;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;

sbyte monsterNum;

extern void DrawAll();
extern void Wait(byte t);

void Main()
{
    byte key, timeDenom;

    // InitSprites(); 
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    
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
    RemainCount = 3;
    stage:
    InitStage();
    try:
    InitTrying();
    Clock = 0;
    monsterNum = 0;
    timeDenom = MaxTimeDenom;
    Sound_Start();     
    // StartBGM();
    do {
        if (ScanStop()) return;
        if ((Clock & 1) == 0) {
            FallMan();
            FallMonsters();
        }
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
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
                    // StopBGM();
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
            MoveLifts();
        }
        // UpdateSprites();
        if ((Clock & 1) == 0) {
            BlinkItems();
            Wait(1);
            DrawAll();
        }
        ++Clock;
        if ((Man.status & Actor_Live) == 0) {
            goto lose;
        }
    } while (ItemCount != 0);
    Wait(30);
    // StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(1);
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
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}

void _deb(){}