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
// #include "Sound.h"
#include "VVram.h"


constexpr byte MaxTimeDenom = 50;
constexpr byte BonusRate = 4;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;

extern void Wait10();

void Main()
{
    byte key, timeDenom;

    // InitSprites(); 
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
    Clock = 0;
    timeDenom = MaxTimeDenom;
    // InitSound();
    InitTrying();
    PrintStatus();
    DrawFence();
    while (!StartEnemyRobo());
    DrawAll();
    // Sound_Start();     
    Wait(100);
    // StartBGM();
    do {
        // if (ScanStop()) goto exit;
        MoveMyBullets();
        if ((Clock & 1) == 0) {
            MoveEnemyBullets();
        }
        if ((Clock & 3) == 0) {
            UpdateBangs();
            MoveMyRobo();
            // Wait(1);
            --timeDenom;
            if (timeDenom == 0) {
                --StageTime;
                timeDenom = MaxTimeDenom;
                PrintTime();
                if (StageTime == 0) {
                    // StopBGM();
                    PrintTimeUp();
                    Wait10();
                    goto lose;
                }
            }
        }
        if ((Clock & 7) == 0) {
            StartEnemyRobo();
            MoveEnemyRobos();
        }
        if ((Clock & 0x0f) == 0) {
            Wait(1);
            DrawAll();
        }
        ++Clock;
        if (MyFort.life == 0) {
            Wait10();
            // StopBGM();
            lose:
            --RemainCount;
            if (RemainCount > 0) {
                goto try;
            } 
            PrintGameOver();
            // Sound_GameOver();
            Wait(200);
            goto title;
        }
    } while (EnemyFort.life > 0);
    // StopBGM();
    Wait10();
    // Sound_Clear();
    Wait(150);
    while (StageTime >= BonusRate) {
        AddScore(3);
        StageTime -= BonusRate;
        PrintTime();
        DrawAll();
        // Sound_Beep();
        Wait(5 + 3);
    }
    StageTime = 0;
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}


static void Wait10()
{
    repeat(20) {
        UpdateBangs();
        Wait(1);
        DrawAll();
    }
}


void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    // PresendVram();
    // CallSound();
}

void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}