#include "Fighter.h"
#include "VVram.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "FighterBullet.h"
#include "Bang.h"
#include "Sound.h"
#include "Status.h"
#include "Coord.h"
#include "Chars.h"

constexpr byte InitialX = (VVramWidth / 2 - 1) * CoordRate;
constexpr byte InitialY = (VVramHeight - 2 - 1) * CoordRate;
constexpr byte CrashRange = 16 * CoordRate;
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
    CrashCount = 5;
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
            PrintRemain();
        }
        return;
    }

    key = ScanKeys();
    if ((key & Keys_Left) != 0 && FighterX > 0) {
        --FighterX;
    }
    if ((key & Keys_Right) != 0 && FighterX < (VVramWidth - 2) * CoordRate) {
        ++FighterX;
    }
    if ((key & Keys_Up) != 0 && FighterY > 0) {
        --FighterY;
    }
    if ((key & Keys_Down) != 0 && FighterY < (VVramHeight - 2) * CoordRate) {
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
        Show();
    }
    StartFighterBullet((key & Keys_Button0) != 0);
}


bool HitBulletFighter(byte x, byte y)
{
    if (
        CrashCount == 0 && ReviveCount == 0 &&
        x + CoordRate / 4 >= FighterX  &&
        FighterX + CoordRate * 7 / 4 >= x  &&
        y + CoordRate / 4 >= FighterY  &&
        FighterY + CoordRate * 7 / 4 >= y
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
        x + CoordRate * 6 / 4 >= FighterX  &&
        FighterX + CoordRate * 6 / 4 >= x  &&
        y + CoordRate / 6 >= FighterY  &&
        FighterY + CoordRate * 6 / 4 >= y
    ) {
        Crash();
        return true;
    }
    return false;
}
