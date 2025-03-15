#include "Fighter.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "FighterBullet.h"
#include "Bang.h"
#include "Barrier.h"
#include "Sound.h"
#include "Status.h"
#include "Main.h"
#include "Chars.h"
#include "Vram.h"

constexpr byte InitialX = (WindowWidth / 2 - 1) * CoordRate;
constexpr byte InitialY = (WindowHeight - 4) * CoordRate;
constexpr byte CrashRange = 8 * CoordRate;
constexpr byte ReviveTime = 31 * CoordRate;

byte FighterX, FighterY;
static byte CrashCount;
static byte ReviveCount;

static void Show()
{
    ShowSprite(Sprite_Fighter, FighterX, FighterY, Pattern_Fighter);
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
    StartBang(FighterX + CoordRate, FighterY + CoordRate, true);
    CrashCount = 1;
    PrintStatus();
}


void MoveFighter()
{
    byte key;
    if (CrashCount >= 1) {
        ++CrashCount;
        if (CrashCount >= CrashRange) {
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
    if ((key & Keys_Right) != 0 && FighterX < (WindowWidth - 2) * CoordRate) {
        ++FighterX;
    }
    if ((key & Keys_Up) != 0 && FighterY > CoordRate * 2) {
        --FighterY;
    }
    if ((key & Keys_Down) != 0 && FighterY < (WindowHeight - 2) * CoordRate) {
        ++FighterY;
    }
    if (ReviveCount > 0) {
        --ReviveCount;
        if (((ReviveCount >> CoordShift) & 1) != 0) {
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
        x >= FighterX && x < FighterX + CoordRate &&
        y >= FighterY && y < FighterY + CoordRate 
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
        x + CoordRate >= FighterX && x < FighterX + CoordRate &&
        y + CoordRate >= FighterY && y < FighterY + CoordRate 
    ) {
        Crash();
        return true;
    }
    return false;
}
