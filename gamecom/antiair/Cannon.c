#include "Cannon.h"
#include "VVram.h"
#include "Sprite.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Bullet.h"
#include "Block.h"
#include "Bang.h"
#include "Sound.h"

constexpr byte InitialX = (VVramWidth / 2 - 1) * CoordRate;
constexpr byte InitialY = (WindowHeight - 2) * CoordRate;

Movable Cannon;
bool CannonLive;

static void Show()
{
    byte pattern;
    if (!CannonLive) return;
    pattern = CanFire() ? Pattern_CannonOn : Pattern_CannonOff;
    ShowSprite(&Cannon, pattern);
}

void InitCannon()
{
    Cannon.sprite = Sprite_Cannon;
    Cannon.x = InitialX;
    Cannon.y = InitialY;
    CannonLive = true;
    Show();
}

static bool CanMove(sbyte dx)
{
    byte x;
    if ((Cannon.x & CoordMask) != 0) return true;
    x = Cannon.x >> CoordShift;
    if (dx > 0) {
        x += 2;
    }
    else {
        --x;
    }
    return Ground[x] == 0;
}

void MoveFighter()
{
    byte key;
    if (!CannonLive) return;
    key = ScanKeys();
    if ((key & Keys_Left) != 0 && Cannon.x > 0 && CanMove(-1)) {
        --Cannon.x;
    }
    if ((key & Keys_Right) != 0 && Cannon.x < (VVramWidth - 2) * CoordRate && CanMove(1)) {
        ++Cannon.x;
    }
    Show();
    if ((key & Keys_Button0) != 0) {
        StartBullet();
    }
}


bool HitCannon(byte x, byte y, byte width)
{
    if (!CannonLive) return false;
    if (
        x < Cannon.x + CoordRate * 2 && Cannon.x < x + width &&
        y < Cannon.y + CoordRate * 2 && Cannon.y < y + CoordRate * 2
    ) {
        HideSprite(Sprite_Cannon);
        CannonLive = false;
        // Sound_LargeBang();
        Sound_Loose();
        StartLargeBang(Cannon.x + CoordRate, Cannon.y + CoordRate);
        return true;
    }
    return false;
}