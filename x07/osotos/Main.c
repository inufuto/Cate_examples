#include "Main.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Sound.h"
#include "Sprite.h"
#include "Status.h"
#include "Stage.h"
#include "Man.h"
#include "Monster.h"
#include "Block.h"
#include "Point.h"
#include "VVram.h"

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 5;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte ItemCount;
static byte Clock;
static sbyte monsterNum;

extern void _deb();
extern void ShowStage();

void Main()
{
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
    StageTime = 0;
    
    title:
    Title();
    byte key;
    do {
        key = ScanKeys();
        if (ScanStop()) return;
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
    // StartBGM();
    do {
        if (ScanStop()) return;
        if ((Clock & 3) == 0) {
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
            UpdateBlocks();
            UpdatePoints();
        }
        if ((Clock & 1) == 0) {
            MoveBlocks();
        }
        if ((Clock & 3) == 0) {
            DrawAll();
            Wait(8 / CoordRate);
        }
        ++Clock;
        if ((Man.status & Movable_Live) == 0) {
            goto lose;
        }
    } while (ItemCount != 0);
    DrawAll();
    Wait(30);
    // StopBGM();
    Wait(10);
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(5);
        StageTime -= BonusRate;
        PrintTime();
        DrawAll();
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