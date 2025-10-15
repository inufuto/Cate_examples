#include "Main.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Vram.h"
#include "Sprite.h"
#include "Window.h"
#include "Fort.h"
#include "Fighter.h"
#include "Barrier.h"
#include "Star.h"
#include "Enemy.h"
#include "FighterBullet.h"
#include "EnemyBullet.h"
#include "Status.h"
#include "Bang.h"
#include "Item.h"
#include "Sound.h"
#include "Init.h"

extern void DrawAll();

word Score;
word HiScore;
byte RemainFighterCount;
byte Clock;

void Main()
{
    byte key;

    Init();
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainFighterCount = 3;
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
    RemainFighterCount = 3;
    stage:
    InitStage();
    try:
    InitSound();
    InitTrying();
    ClearScreen();
    PrintStatus();
    DrawFortsOnRader();
    DrawAll();
    DrawFighterOnRader();
    Sound_Start();
    StartBGM();
    Clock = 0;
    do {
        // if (ScanStop()) goto exit;
        ControlFighter();
        if ((Clock & 3) == 0) {
            MoveFighter();
            MoveEnemy();
            StartEnemy();
        }
        MoveFighterBullets();
        MoveEnemyBullets();
        DrawItem();
        if (FighterDyingCount == 0) {
            StopBGM();
            lose:
            --RemainFighterCount;
            if (RemainFighterCount != 0)  goto try;
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
        UpdateBangs();
        if ((Clock & 1) == 0) {
            WaitTimer(2);
            DrawAll();
        }
        PollVSync();
        ++Clock;
    } while (FortCount > 0);
    StopBGM();
    Sound_Clear();
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}

void deb() {}

void DrawAll()
{
    if (WindowChanged) {
        ClearWindow();
        DrawStars();
        PollVSync();
        DrawForts();
        PollVSync();
        DrawBarriers();
        PollVSync();
        WindowBackToFront();
        PollVSync();
        DrawSprites();
        WaitTimer(1);
        WindowToVramAll();
        WindowChanged = false;
    }
    else {
        EraseSprites();
        if (DrawSprites()) {
            WaitTimer(1);
            WindowToVramChanged();
        }
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