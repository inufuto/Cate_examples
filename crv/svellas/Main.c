#include "Main.h"
#include "Status.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Man.h"
#include "Sound.h"
#include "Sprite.h"
#include "Monster.h"

extern void WaitTimer(byte t);

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 3;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
static byte Clock;

void Main() {
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
    Sound_Start();
    StartBGM();
    do {
        // if (ScanStop()) return;
        if ((Clock & 3) == 0) {
            MoveMan();
            if (monsterNum >= 0) {
                MoveMonsters();
                monsterNum -= 7;
            }
            monsterNum += 3;

            WaitTimer(1);
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
        MovePanel();
        UpdateSprites();
        if ((Man.status & Movable_Live) == 0) {
            goto lose;
        }
        ++Clock;
    } while (StarCount != 0);
    UpdateSprites();
    StopBGM();
    WaitTimer(10);
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
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}


void _deb(){}