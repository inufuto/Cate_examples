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
#include "VVram.h"

extern void Init();
extern void Fin();
// extern void WaitTimer(byte t);
// extern void WaitBlankOn();
// extern void WaitBlankOff();
// extern byte PrevKey;

constexpr byte MaxTimeDenom = 50;
constexpr byte BonusRate = 4;

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
byte StageTime;
byte Clock;

extern void Wait();

void Main()
{
    byte key, timeDenom;

    Init(); 
    // PrevKey = 0;
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
    InitSound();
    InitTrying();
    PrintStatus();
    // DrawFence();
    while (!StartEnemyRobo());
    DrawAll();
    Sound_Start();     
    // StartBGM();
    // WaitTimer(1);
    // ScanKeys();
    // PrevKey = 0;
    timeDenom = MaxTimeDenom;
    do {
        // if (ScanStop()) goto exit;
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
                    // StopBGM();
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
        if ((Clock & 0x03) == 0) {
            // WaitBlankOff();
            // WaitBlankOn();
            // WaitTimer(1);
            // ScanKeys();
            ReadStick();
            DrawAll();
            CallSound();
        }
        ++Clock;
        if (MyFort.life == 0) {
            Wait();
            // StopBGM();
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
    // StopBGM();
    Sound_Clear();
    while (StageTime >= BonusRate) {
        AddScore(3);
        StageTime -= BonusRate;
        PrintTime();
        // Sound_Beep();
        Sound_Fire();
        // repeat(5) {
        //     WaitBlankOff();
        //     WaitBlankOn();
        // }
    }
    StageTime = 0;
    PrintStatus();
    ++CurrentStage;
    goto stage;
exit:
    Fin();
}

static void Wait()
{
    repeat(100) {
        UpdateBangs();
        // WaitTimer(1);
        // WaitBlankOff();
        // WaitBlankOn();
        DrawAll();
        CallSound();
    }
}

void DrawAll()
{
     if (VVramChanged) {
        VVramBackToFront();
        DrawSprites();
        VVramToVramAll();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVramChanged();
    }
}

void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}