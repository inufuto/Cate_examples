#include "Main.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Status.h"
// #include "Sound.h"
#include "MyFighter.h"
#include "MyBullet.h"
#include "EnemyFighter.h"
#include "EnemyBullet.h"
#include "GroundEnemy.h"
#include "Fort.h"
#include "Bang.h"
#include "Item.h"
#include "VVram.h"

extern void Wait(byte t);

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

    ClearScreen();
    InitGame();
    PrintStatus();
    GroundToVVram();
    VVramChanged = true;
    DrawAll();
    // Sound_Start();
    Wait(100);
    // StartBGM();
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
        Wait(2);
        DrawAll();
    }
    if (RemainCount == 0) {
        // StopBGM();
        PrintGameOver();
        // Sound_GameOver();
        Wait(200);
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
    PrintScore();
}
