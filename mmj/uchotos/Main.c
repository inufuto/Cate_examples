#include "Main.h"
#include "Status.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Man.h"
#include "Monster.h"
#include "Fire.h"
#include "Debri.h"
#include "Sound.h"
#include "VVram.h"

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 5;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
static byte Clock;

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
        // if (ScanStop()) return;
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
    static sbyte monsterNum = 0;
    static byte timeDenom = MaxTimeDenom;
    DrawAll();
    Sound_Start();
    // StartBGM();
    do {
        // if (ScanStop()) return;
        MoveFires();
        if ((Clock & 3) == 0) {
            ScanDebris();
            FallDebris();
            MoveMan();
            if (monsterNum >= 0) {
                MoveMonsters();
                monsterNum -= 6;
            }
            monsterNum += 4;
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    // StopBGM();
                    DrawAll();
                    PrintTimeUp();
                    Wait(60 * 3);
                    --RemainCount;
                    if (RemainCount > 0) {
                        goto try;
                    }
                    over: 
                    PrintGameOver();
                    Sound_GameOver();
                    goto title;
                }
            }
        }
        if ((Clock & 1) == 0) {
            ShowMan();
            DrawAll();
            Wait(4 / CoordRate);
        }
        ++Clock;
        if (RemainCount == 0) {
            Wait(60);
            // StopBGM();
            goto over;
        }
    } while (ItemCount != 0);
    // StopBGM();
    DrawAll();
    Wait(10);
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
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}

void _deb(){}