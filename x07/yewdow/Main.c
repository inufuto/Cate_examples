#include "Main.h"
#include "Status.h"
#include "Movable.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Sound.h"
#include "Man.h"
#include "Sprite.h"
#include "Item.h"
#include "Car.h"
#include "Monster.h"
#include "Point.h"
#include "Vram.h"

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 4;

word Score;
byte RemainCount;
byte CurrentStage;
byte StageTime;
static byte Clock;

void Main()
{
    byte key, timeDenom;
    sbyte monsterNum;

    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;

    title:
    Title();
    do {
        key = ScanKeys();
        if (ScanStop()) return;
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
        if ((Clock & 3) == 0) {
            UpdatePoints();
            MoveMan();
            if (monsterNum >= 0) {
                MoveMonsters();
                monsterNum -= 10;
            }
            monsterNum += 3;
            if ((Clock & 7) == 0) {
                MoveCars();
                // BlinkItems();
            }
            DrawAll();
            Wait(8 / CoordRate);
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    PrintTimeUp();
                    Wait(120);
                    lose:
                    // StopBGM();
                    // 
                    --RemainCount;
                    if (RemainCount > 0) {
                        goto try;
                    } 
                    PrintGameOver();
                    Sound_GameOver();
                    goto title;
                }
            }
            if (pLostCar != nullptr) {
                LooseCar();
                goto lose;
            }
        }
        // UpdateSprites();
        ++Clock;
        if (ScanStop()) return;
    } while (ItemCount != 0);
    // UpdateSprites();
    Wait(30);
    // StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(2);
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

void _deb(){}