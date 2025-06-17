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

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 4;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
static byte Clock;

void Main()
{
    byte key, timeDenom;
    sbyte monsterNum;

    HiScore = 0;
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
    Sound_Start();
    StartBGM();
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
                BlinkItems();
            }
            UpdateSprites();
            WaitTimer(1);
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    PrintTimeUp();
                    WaitTimer(120);
                    lose:
                    StopBGM();
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
        ++Clock;
    } while (ItemCount != 0);
    UpdateSprites();
    WaitTimer(30);
    StopBGM();
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
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}

void _deb(){}