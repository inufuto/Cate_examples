#include "Main.h"
#include "Status.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Sprite.h"
#include "Sound.h"
#include "Man.h"
#include "Monster.h"
#include "Fire.h"
#include "Point.h"
#include "VVram.h"

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte FoodCount;
static byte Clock;
static sbyte monsterNum;

extern void _deb();
void Main()
{
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    FoodCount = 0;

    title:
    Title();
    byte key;
    do {
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

    play:
    Score = 0;
    if ((key & Keys_Button1) == 0 && (key & Keys_Dir) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    stage:
    InitStage();
    try:
    InitTrying();
    Clock = 0;
    monsterNum = 0;
    byte timeDenom = MaxTimeDenom;
    Sound_Start();
    StartBGM();
    do {
        //     if (ScanStop()) goto exit;
        if ((Clock & 3) == 0) {
            MoveMan();
            UpdatePoints();
        }
        if ((Clock & 7) == 0) {
            MoveMonsters();
        }
        MoveFires();
        if ((Clock & 3) == 0) {
            DrawAll();
            WaitTimer(8 / CoordRate);
        }
        ++Clock;
        if (FoodCount == 0) {
            WaitTimer(30);
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
        if ((Man.status & Movable_Live) == 0) {
            goto lose;
        }
    } while (MonsterCount != 0);
    DrawAll();
    WaitTimer(30);
    StopBGM();
    Sound_Clear();
    while (FoodCount != 0) {
        --FoodCount;
        AddScore(50);
        PrintStatus();
        Sound_Bonus();
        WaitTimer(30);
    }
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