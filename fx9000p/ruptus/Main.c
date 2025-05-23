#include "Main.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "Vram.h"
#include "Sprite.h"
#include "VVram.h"
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
// #include "Sound.h"

extern void Wait(byte t);
extern void DrawAll();

word Score;
byte CurrentStage;
byte RemainCount;
byte Clock;

void Main()
{
    byte key;

    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
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
    ClearScreen();
    PrintStatus();
    DrawFortsOnRader();
    DrawFighterOnRader();
    DrawAll();
    // Sound_Start();
    Wait(100);
    // StartBGM();
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
            // StopBGM();
            lose:
            --RemainCount;
            if (RemainCount != 0)  goto try;
            PrintGameOver();
            // Sound_GameOver();
            Wait(200);
            goto title;
        }
        UpdateBangs();
        
        if ((Clock & 3) == 0) {
            Wait(1);
            DrawAll();
            // CallSound();
        }
        ++Clock;
    } while (FortCount > 0);
    // StopBGM();
    // Sound_Clear();
    Wait(150);
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        ClearVVram();
        DrawStars();
        DrawForts();
        DrawBarriers();
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
    PrintScore();
}