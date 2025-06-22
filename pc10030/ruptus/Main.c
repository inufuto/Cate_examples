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
#include "Sound.h"
#include "Rader.h"

// extern void Fin();
extern void WaitTimer(byte t);
extern void DrawAll();

word Score;
word HiScore;
byte RemainFighterCount;
byte Clock;

void Main()
{
    byte key;

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
    InitTrying();
    ClearScreen();
    PrintStatus();
    DrawAll();
    DrawFortsOnRader();
    DrawFighterOnRader();
    Sound_Start();
    // StartBGM();
    Clock = 0;
    do {
        // if (ScanStop()) goto exit;
        UpdateBangs();
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
            --RemainFighterCount;
            if (RemainFighterCount != 0)  goto try;
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
        if ((Clock & 3) == 0) {
            DrawAll();
            WaitTimer(4);
        }
        ++Clock;
    } while (FortCount > 0);
    // StopBGM();
    Sound_Clear();
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}

static void DrawAll()
{
    if (VVramChanged) {
        EraseSprites();
        ClearVVram();
        DrawStars();
        DrawForts();
        DrawBarriers();
        VVramToVram();
        DrawSprites();
        SwitchVram();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        VVramToVram();
        DrawSprites();
        SwitchVram();
    }
    CallSound();
}

void AddScore(word pts) 
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}