#include "Main.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Sprite.h"
#include "Fighter.h"
#include "FighterBullet.h"
#include "SkyEnemy.h"
#include "EnemyBullet.h"
#include "Status.h"
#include "Bang.h"
#include "Barrier.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Sound.h"
#include "Item.h"

extern void WaitTimer(byte t);

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
static byte Clock;

void Main()
{
    byte key;
    
    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;

    title:
    Title();
    do {
        if (ScanStop()) return;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

    play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;

    InitStage();
    InitTrying();
    PrintStatus();
    DrawAll();
    Sound_Start();
    StartBGM();
    Clock = 0;
loop:
    if (ScanStop()) return;
    if ((Clock & 0x01) == 0) {
        MoveFighter();
        MoveEnemyBullets();
    }
    if ((Clock & 0x03) == 0) {
        MoveSkyEnemies();
        MoveBarriers();
        MoveItem();}
    if ((Clock & 0x07) == 0) {
        MoveFort();
    }
    MoveFighterBullets();
    if ((Clock & 0x0f) == 0) {
        ScrollGround();
        MoveGroundEnemy();
    }
    if ((Clock & 0x07) == 0) {
        UpdateBangs();
        DrawAll();
        WaitTimer(3);
    }
    if (RemainCount == 0) {
        StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }

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

void _deb() {}