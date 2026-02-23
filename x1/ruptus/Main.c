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
#include "Rader.h"

extern void Init();
// extern void Fin();
extern void WaitTimer(byte t);
extern void DrawAll();

word Score;
word HiScore;
byte RemainFighterCount;
byte Clock;

extern void _breakp();

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
        UpdateBangs();
        CallSound();
        ControlFighter();
        if ((Clock & 3) == 0) {
            CallSound();
            MoveFighter();
            CallSound();
            MoveEnemy();
            CallSound();
            StartEnemy();
            CallSound();
        }
        MoveFighterBullets();
        CallSound();
        MoveEnemyBullets();
        CallSound();
        DrawItem();
        CallSound();
        if (FighterDyingCount == 0) {
            StopBGM();
            lose:
            --RemainFighterCount;
            if (RemainFighterCount != 0)  goto try;
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
        ++Clock;
        if ((Clock & 1) == 0) {
            DrawAll();
        }
        while (CallSound() == 0);
    } while (FortCount > 0);
    StopBGM();
    Sound_Clear();
    PrintStatus();
    ++CurrentStage;
    goto stage;
// exit:
//     Fin();
}

void DrawAll()
{
    if (WindowChanged) {
        ClearWindowBack();
        CallSound();
        DrawStars();
        CallSound();
        DrawForts();
        CallSound();
        DrawBarriers();
        CallSound();
        WindowBackToVram();
        CallSound();
        WindowChanged = false;
    }
    EraseSprites();
    CallSound();
    DrawSprites();
    CallSound();
    WindowFrontToVram();
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


void _breakp(){}