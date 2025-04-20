#include "Status.h"
#include "ScanKeys.h"
#include "Sound.h"
#include "Stage.h"
#include "Cannon.h"
#include "Sprite.h"
#include "Bullet.h"
#include "Vram.h"
#include "VVram.h"
#include "Ufo.h"
#include "Bang.h"
#include "Block.h"
#include "Status.h"

extern void _deb();
extern void WaitTimer(byte t);

word Score;
word HiScore;
byte RemainCount;
byte CurrentStage;
static byte Clock;

void Main()
{
    byte key, linger;

    HiScore = 0;
    Score = 0;
    CurrentStage = 0;
    RemainCount = 3;

    title:
    Title();
    do {
        // if (ScanStop()) return;
        key = ScanKeys();
    } while ((key & (Keys_Button0 | Keys_Button1)) == 0);
    
    play:
    Clock = 0;
    Score = 0;
    if ((key & Keys_Button1) == 0) {
        CurrentStage = 0;
    }
    RemainCount = 3;
    InitStage();
    try:
    linger = 0;
    InitPlaying();
    DrawGround();
    DrawAll();
    Sound_Start();
    StartBGM();

    loop:
    // if (ScanStop()) return;
    if ((Clock & 0x01) == 0) {
        MoveFighter();
        MoveBlocks();
    }
    MoveBullets();
    if ((Clock & 0x07) == 0) {
        MoveUfos();
        UpdateBlocks();
    }
    if ((Clock & 0x07) == 0) {
        UpdateBangs();
        DrawAll();
        WaitTimer(2 * 8 / CoordRate);
    }
    else if (BackgroundChanged) {
        DrawAll();
    }
    ++Clock;
    // UpdateSprites();
    if (UfoCount == 0) {
        ++linger;
        if (linger > 250 * CoordRate / 8) {
            ++CurrentStage;
            PrintStage();
            InitStage();
            linger = 0;
        }
    }
    if (!CannonLive) {
        ++linger;
        if (linger > 200 * CoordRate / 8) {
            StopBGM();
            --RemainCount;
            if (RemainCount != 0) {
                goto try;
            }
            PrintGameOver();
            Sound_GameOver();
            goto title;
        }
    }
    goto loop;
}

void _deb(){}