#include "Fighter.h"
#include "VVram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Main.h"
#include "Status.h"
#include "ScanKeys.h"
#include "FighterBullet.h"
#include "Bang.h"
#include "Barrier.h"
#include "Sound.h"

constexpr byte InitialX = (VVramWidth / 2 - 1) * CoordRate;
constexpr byte InitialY = (VVramHeight - 2 - 1) * CoordRate;
constexpr byte CrashRange = 8 * CoordRate;
constexpr byte ReviveTime = 31 * CoordRate;

Fighter Fighter;

static void Show()
{
    ShowSprite(&Fighter, Pattern_Fighter);
}

static void Hide()
{
    HideSprite(Sprite_Fighter);
}


void InitFighter()
{
    Fighter.x = InitialX;
    Fighter.y = InitialY;
    Fighter.sprite = Sprite_Fighter;
    Fighter.crashCount = 0;
    Fighter.reviveCount = 0;
    Show();
}


static void Crash()
{
    Hide();
    Sound_LargeBang();
    Sound_Loose();
    StartLargeBang(Fighter.x + CoordRate, Fighter.y + CoordRate);
    Fighter.crashCount = 1;
}

void MoveFighter()
{
    byte key;
    if (Fighter.crashCount != 0) {
        ++Fighter.crashCount;
        if (Fighter.crashCount >= CrashRange) {
            --RemainCount;
            Fighter.x = InitialX;
            Fighter.y = InitialY;
            Fighter.crashCount = 0;
            Fighter.reviveCount = ReviveTime;
            PrintRemain();
        }
        return;
    }

    key = ScanKeys();
    if ((key & Keys_Left) != 0 && Fighter.x != 0) {
        --Fighter.x;
    }
    if ((key & Keys_Right) != 0 && Fighter.x < (VVramWidth - 2) * CoordRate) {
        ++Fighter.x;
    }
    if ((key & Keys_Up) != 0 && Fighter.y > CoordRate * 2) {
        --Fighter.y;
    }
    if ((key & Keys_Down) != 0 && Fighter.y < (VVramHeight - 2) * CoordRate) {
        ++Fighter.y;
    }
    if (Fighter.reviveCount != 0) {
        --Fighter.reviveCount;
        if (((Fighter.reviveCount >> CoordShift) & 1) != 0) {
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
        }
    }
    if (Fighter.crashCount == 0) {
        StartFighterBullet((key & Keys_Button0) != 0);
    }
}


bool HitBulletFighter(byte x, byte y)
{
    if (
        Fighter.crashCount == 0 && Fighter.reviveCount == 0 &&
        x >= Fighter.x && x < Fighter.x + CoordRate &&
        y >= Fighter.y && y < Fighter.y + CoordRate 
    ) {
        Crash();
        return true;
    }
    return false;
}


bool HitEnemyFighter(byte x, byte y)
{
    if (
        Fighter.crashCount == 0 && Fighter.reviveCount == 0 &&
        x + CoordRate >= Fighter.x && x < Fighter.x + CoordRate &&
        y + CoordRate >= Fighter.y && y < Fighter.y + CoordRate 
    ) {
        Crash();
        return true;
    }
    return false;
}
