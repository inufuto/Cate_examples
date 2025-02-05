#include "Main.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Status.h"
#include "Sound.h"
#include "MyFighter.h"
#include "MyBullet.h"
#include "EnemyFighter.h"
#include "EnemyBullet.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Bang.h"
#include "Item.h"
#include "VVram.h"

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
static byte Clock;

extern void _deb();

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
        // if (ScanStop()) goto exit;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

    play:
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
                            // CurrentStage = 8;
    }
    RemainCount = 3;

    ClearScreen();
    InitGame();
    PrintStatus();
    GroundToVVram();
    VVramChanged = true;
    _deb();
    DrawAll();
    Sound_Start();
    StartBGM();
    Clock = 0;
loop:
    // if (ScanStop()) goto exit;
    MoveMyBullets();
    if ((Clock & 0x01) == 0) {
        MoveMyFighter();
        MoveEnemyFighters();
        MoveEnemyBullets();
    }
    if ((Clock & 0x03) == 0) {
        MoveGroundEnemies();
    }
    if ((Clock & 0x07) == 0) {
        UpdateBangs();
        MoveItem();
    }
    if ((Clock & 0x0f) == 0) {
        MoveForts();
        ScrollBackground();
        if (GroundChanged) {
            GroundToVVram();
            GroundChanged = false;
            VVramChanged = true;
        }
    }
    if ((Clock & 0x01) == 0) {
        WaitTimer(4);
        DrawAll();
        // CallSound();
    }
    if (RemainCount == 0) {
        StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }
    // UpdateSprites();
    ++Clock;
    goto loop;
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
    // StatusToVVram();
}


void _deb(){}
