#include "Cannon.h"
#include "VVram.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "Bullet.h"
#include "Block.h"
#include "Bang.h"
#include "Sound.h"

constexpr byte InitialX = (VVramWidth / 2 - 1) * CoordRate;
constexpr byte InitialY = (VVramHeight - 2) * CoordRate;

const byte[] CannonChars = {
    0x0c, 0x03, 0x07, 0x0d, 
    0x00, 0x00, 0x0a, 0x0a,
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
    if ((key & Keys_Right) != 0 && Cannon.x < (VVramWidth - 2) * CoordRate && CanMove(1)) {
        ++Cannon.x;
    }
    if ((key & Keys_Button0) != 0) {
        StartBullet();
    }
    Show();
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