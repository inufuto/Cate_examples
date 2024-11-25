#include "Main.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Sound.h"
#include "Sprite.h"
#include "Status.h"
#include "Stage.h"
#include "Man.h"
#include "Lift.h"
#include "Monster.h"
#include "VVram.h"

constexpr byte MaxTimeDenom = 60 / 8;
constexpr byte BonusRate = 5;

word Score;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte ItemCount;
static byte Clock;
static sbyte monsterNum;

extern void _deb();
void Main()
{
    byte key, timeDenom;

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
    timeDenom = MaxTimeDenom;
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
        }
        if ((Clock & 7) == 0) {
            MoveLifts();
        }
        if ((Clock & 3) == 0) {
            DrawAll();
            // WaitTimer(10);
        }
        ++Clock;
        if ((Man.status & Man_Live) == 0) {
            goto lose;
        }
    } while (!Cleared);
    DrawAll();
    // StopBGM();
    // WaitTimer(10);
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(5);
        StageTime -= BonusRate;
        PrintTime();
        Sound_Beep();
    }
    StageTime = 0;
    PrintStatus();

    if (ItemCount == 0) {
        byte n;
        PrintPerfect();
        n = pStage->itemCount;
        while (n != 0) {
            --n;
            AddScore(10);
            Sound_Bonus();
            // WaitTimer(30);
        }
    }
    ++CurrentStage;
    goto stage;
}


void AddScore(word pts) 
{
    Score += pts;
    PrintScore();
}

void _deb(){}