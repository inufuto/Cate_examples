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
#include "Fire.h"
#include "Monster.h"
#include "VVram.h"

extern void WaitTimer(byte t);

constexpr byte MaxTimeDenom = 50 / (8 / CoordRate);
constexpr byte BonusRate = 8;
constexpr byte FireInterval = CoordRate * 12;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;
sbyte monsterNum;
static byte fireCount;

void Main()
{
    byte key, timeDenom;

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
    fireCount = FireInterval;
    timeDenom = MaxTimeDenom;
    Sound_Start();     
    StartBGM();
    do {
            // if (ScanStop()) goto exit;
        --fireCount;
        if (fireCount == 0) {
            StartFire();
            fireCount = FireInterval;
        }
        if ((Clock & (CoordRate * 2 - 1)) == 0) {
            if (PowerTime > 0) {
                --PowerTime;
            }
        }
        if ((Clock & 3) == 0) {
            FallMan();
            MoveMan();
            MoveFires();
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
                    DrawAll();
                    --RemainCount;
                    if (RemainCount > 0) {
                        goto try;
                    } 
                    PrintGameOver();
                    Sound_GameOver();
                    goto title;
                }
            }
            WaitTimer(8);
            DrawAll();
        }
        // UpdateSprites();
        ++Clock;
        if ((Man.status & Actor_Live) == 0) {
            goto lose;
        }
        //PollVSync();
    } while (Man._.y >= 2); 
    PowerTime = 0;
    ShowMan();
    // UpdateSprites();
    DrawAll();
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
// exit:
//     Fin();
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