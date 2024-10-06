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
#include "Vram.h"

extern void WaitTimer(byte t);

word Score;
byte RemainCount;
byte CurrentStage;
static byte Clock;

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

    InitGame();
    PrintStatus();
    // GroundToVram();
    // UpdateSprites();
    DrawAll();
    Sound_Start();
    StartBGM();
    Clock = 0;
loop:
    MoveMyFighter();
    MoveMyBullets();
    MoveEnemyFighters();
    if ((Clock & 0x01) == 0) {
        MoveEnemyBullets();
        MoveGroundEnemies();
    }
    if ((Clock & 0x03) == 0) {
        UpdateBangs();
        MoveItem();
    }
    if ((Clock & 0x07) == 0) {
        MoveForts();
        ScrollBackground();
    }
    if (RemainCount == 0) {
        StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }
    WaitTimer(2);
    DrawAll();
    ++Clock;
    goto loop;
// exit:
//     Fin();
}


void AddScore(word pts)
{
    Score += pts;
    // if (Score > HiScore) {
    //     HiScore = Score;
    // }
    PrintScore();
    // StatusToVVram();
}

void _deb(){}