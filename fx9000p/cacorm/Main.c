#include "Main.h"
#include "ScanKeys.h"
#include "Vram.h"
// #include "Sound.h"
#include "Status.h"
#include "Movable.h"
#include "Actor.h"
#include "Stage.h"
#include "Sprite.h"
#include "Man.h"
#include "Monster.h"
#include "Item.h"
#include "Point.h"
#include "VVram.h"

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

extern void _deb();
void Main()
{
    byte key, timeDenom;

    // Init();
    // InitSprites(); 
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
    InitTrying();
    Clock = 0;
    monsterNum = 0;
    timeDenom = MaxTimeDenom;
    // Sound_Start();
    Wait(100);
    // StartBGM();
    do {
        //     if (ScanStop()) goto exit;
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
            // Wait(1);
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
                    // Sound_GameOver();
                    Wait(200);
                    goto title;
                }
            }
        }
        // UpdateSprites();
        if ((Clock & 0x01) == 0) {
            Wait(2);
            DrawAll();
        }
        ++Clock;
        if ((Man.status & Actor_Live) == 0) {
            goto lose;
        }
        // ScanKeys();
    } while (ItemCount != 0);
    // ShowMan();
    // UpdateSprites();
    // StopBGM();
    Wait(10 + 150);
    // Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(5);
        StageTime -= BonusRate;
        PrintTime();
        // PresendVram();
        // Sound_Beep();
        Wait(3);
    }
    StageTime = 0;
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}


void AddScore(word pts) 
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
}

void _deb(){}