#include "Stage.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Fighter.h"
#include "FighterBullet.h"
#include "EnemyBullet.h"
#include "Status.h"
#include "Bang.h"
#include "Sound.h"
#include "Team.h"
#include "EnemyRow.h"
#include "Vram.h"
#include "Star.h"
#include "Enemy.h"
#include "Item.h"
#include "Coord.h"

extern void WaitTimer(byte t);

word Score;
byte RemainCount;
byte CurrentStage;
static byte Clock;
static byte ClearTime;
static byte enemyNum;

void Main()
{
    byte key;
    
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;

    title:
    Title();
    do {
        if (ScanStop()) return;
        key = ScanKeysWait();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);

play:
    EnemyCount = 0;
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    InitPlaying();
    Sound_Start();
    StartBGM();
    Clock = 0;
    enemyNum = 0;
stage:
    ClearTime = 150 * CoordRate / 8;
    InitStage();
loop:
    if (ScanStop()) return;
    if ((Clock & 0x01) == 0) {
        MoveFighter();
        MoveEnemyBullets();
        MoveTeams();
        MoveMovingEnemies();
    }
    if ((Clock & 0x03) == 0) {
        MoveItem();
    }
    if ((Clock & 0x0f) == 0) {
        StartTeam();
        MoveEnemyRows();
        MoveStars();
    }
    if ((Clock & 0x07) == 0) {
        UpdateBangs();
    }
    MoveFighterBullets();
    if ((Clock & 0x03) == 0) {
        DrawAll();
        WaitTimer(2);
    }
    if (RemainCount == 0) {
        StopBGM();
        PrintGameOver();
        Sound_GameOver();
        goto title;
    }
    if (EnemyCount == 0) {
        if (ClearTime == 0) {
            ++CurrentStage;
            PrintStatus();
            goto stage;
        }
        --ClearTime;
    }
    ++Clock;
    // RotateSprites();
    // UpdateSprites();
    goto loop;
}


void _deb(){}