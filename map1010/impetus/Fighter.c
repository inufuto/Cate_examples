#include "Fighter.h"
#include "VVram.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "FighterBullet.h"
#include "Bang.h"
#include "Barrier.h"
#include "Sound.h"
#include "Status.h"
#include "Main.h"
#include "Chars.h"

constexpr byte InitialX = VVramWidth / 2 - 1;
constexpr byte InitialY = VVramHeight - 2 - 1;
constexpr byte CrashTime = 8;
constexpr byte ReviveTime = 31;

byte FighterX, FighterY;
static byte CrashCount;
static byte ReviveCount;

static void Show()
{
    ShowSprite(Sprite_Fighter, FighterX, FighterY, Char_Fighter);
}

static void Hide()
{
    HideSprite(Sprite_Fighter);
}


void InitFighter()
{
    FighterX = InitialX;
    FighterY = InitialY;
    Show();
    CrashCount = 0;
    ReviveCount = 0;
}


static void Crash()
{
    Hide();
    Sound_LargeBang();
    // Sound_Loose();
    StartBang(FighterX + 1, FighterY + 1, true);
    CrashCount = 1;
    PrintStatus();
}


void MoveFighter()
{
    byte key;
    if (CrashCount >= 1) {
        ++CrashCount;
        if (CrashCount >= CrashTime) {
            --RemainCount;
            FighterX = InitialX;
            FighterY = InitialY;
            CrashCount = 0;
            ReviveCount = ReviveTime;
            PrintStatus();
        }
        return;
    }

    key = ScanKeys();
    if ((key & Keys_Left) != 0 && FighterX > 0) {
        --FighterX;
    }
    if ((key & Keys_Right) != 0 && FighterX < VVramWidth - 2) {
        ++FighterX;
    }
    if ((key & Keys_Up) != 0 && FighterY > 2) {
        --FighterY;
    }
    if ((key & Keys_Down) != 0 && FighterY < VVramHeight - 2) {
        ++FighterY;
    }
    if (ReviveCount > 0) {
        --ReviveCount;
        if ((ReviveCount & 1) != 0) {
            Show();
        }
        else {
            Hide();
        }
    }
    else {
        if (HitFighterBarrier()) {
            Crash();
        }
        else {
            Show();
            StartFighterBullet((key & Keys_Button0) != 0);
        }
    }
}


bool HitBulletFighter(byte x, byte y)
{
    if (
        CrashCount == 0 && ReviveCount == 0 &&
        x >= FighterX && x < FighterX + 2 &&
        y >= FighterY && y < FighterY + 2 
    ) {
        Crash();
        return true;
    }
    return false;
}


bool HitEnemyFighter(byte x, byte y)
{
    if (
        CrashCount == 0 && ReviveCount == 0 &&
        x + 1 >= FighterX && x < FighterX + 2 &&
        y + 1 >= FighterY && y < FighterY + 2
    ) {
        Crash();
        return true;
    }
    return false;
}
