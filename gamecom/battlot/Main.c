#include "Main.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Status.h"
#include "Sprite.h"
#include "Vram.h"
#include "Robo.h"
#include "Bullet.h"
#include "Bang.h"
#include "Fort.h"
#include "Sound.h"

extern void WaitTimer(byte t);

constexpr byte MaxTimeDenom = 50;
constexpr byte BonusRate = 4;

word Score;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;

extern void Wait();

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
        if (ScanStop()) return;
        key = ScanKeysWait();
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
    Clock = 0;
    timeDenom = MaxTimeDenom;
    InitTrying();
    PrintStatus();
    while (!StartEnemyRobo());
    DrawAll();
    Sound_Start();     
    StartBGM();
    do {
        if (ScanStop()) return;
        MoveMyBullets();
        if ((Clock & 1) == 0) {
            MoveEnemyBullets();
        }
        if ((Clock & 3) == 0) {
            UpdateBangs();
            MoveMyRobo();
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    StopBGM();
                    PrintTimeUp();
                    Wait();
                    goto lose;
                }
            }
        }
        if ((Clock & 7) == 0) {
            StartEnemyRobo();
            MoveEnemyRobos();
        }
        if ((Clock & 3) == 0) {
            DrawAll();
            WaitTimer(1);
        }
        ++Clock;
        if (MyFort.life == 0) {
            Wait();
            StopBGM();
            lose:
            --RemainCount;
            if (RemainCount > 0) {
                goto try;
            } 
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
    } while (EnemyFort.life > 0);
    Wait();
    StopBGM();
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

static void Wait()
{
    repeat(100) {
        UpdateBangs();
        DrawAll();
        WaitTimer(1);
    }
}

void AddScore(word pts) 
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
}