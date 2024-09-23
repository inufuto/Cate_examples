#include "Cannon.h"
#include "VVram.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "Bullet.h"
#include "Block.h"
#include "Bang.h"
#include "Sound.h"

constexpr byte InitialX = (WindowWidth / 2 - 1) * CoordRate;
constexpr byte InitialY = (WindowHeight - 2) * CoordRate;

const byte[] CannonChars = {
    0x83, 0x82, 0xa3, 0xa2, 0x20, 0x20, 0x95, 0x95,
};
Movable Cannon;
bool CannonLive;

static void Show()
{
    ptr<byte> pChars;
    if (!CannonLive) return;
    pChars = CanFire() ? CannonChars : CannonChars + 4;
    ShowSprite(&Cannon, pChars);
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
    if ((key & Keys_Right) != 0 && Cannon.x < (WindowWidth - 2) * CoordRate && CanMove(1)) {
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