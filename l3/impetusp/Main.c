#include "Main.h"
#include "Status.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Stage.h"
#include "Sound.h"
#include "Sprite.h"
#include "Fighter.h"
#include "SkyEnemy.h"
#include "GroundEnemy.h"
#include "FighterBullet.h"
#include "EnemyBullet.h"
#include "Bang.h"
#include "Barrier.h"
#include "Fort.h"
#include "Item.h"

extern void WaitTimer(byte t);

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
static byte Clock;

void Main()
{   
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;
title:
    Title();
    byte key;
    do {
        // if (ScanStop()) return;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
play:
    Score = 0;
    if ((key & Keys_Button1) == 0 && (key & Keys_Dir) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;

    InitPlaying();
    Sound_Start();
    // StartBGM();
    Clock = 0;
loop:
    if ((Clock & 0x01) == 0) {
        MoveFighter();
        //PollVSync();
        MoveEnemyBullets();
    }
    MoveFighterBullets();
    if ((Clock & 0x03) == 0) {
        MoveSkyEnemies();
        MoveBarriers();
        MoveItem();
        UpdateBangs();
    }
    if ((Clock & 0x07) == 0) {
        MoveForts();
        ScrollGround();
        MoveGroundEnemy();
    }
    if ((Clock & 0x01) == 0) {
        DrawAll();
        WaitTimer(4 / CoordRate);
    }
    if (RemainCount == 0) {
        // StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }
    //PollVSync();
    ++Clock;
    goto loop;
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