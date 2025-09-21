#include "Fighter.h"
#include "Stage.h"
#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"
#include "Direction.h"
#include "ScanKeys.h"
#include "FighterBullet.h"
#include "Bang.h"
#include "Barrier.h"
#include "Fort.h"
#include "Mover.h"
#include "Item.h"
#include "Main.h"
#include "Status.h"
#include "Sound.h"
#include "Vram.h"

constexpr byte FixedX = VVramWidth / 2 * 8 - 8;
constexpr byte FixedY = VVramHeight / 2 * 8 - 8;
constexpr byte SpriteColor = 15;
constexpr byte HalfSize = 1;

byte FighterX, FighterY;
sbyte FighterDx, FighterDy;
byte FighterDirection;
static sbyte numerator, denominator;
sbyte FighterDyingCount;

static void Draw() 
{
    ShowSprite(Sprite_Fighter, FixedX >> 3, FixedY >> 3, 
        Char_Fighter + (FighterDirection << 2));
}

static void Locate() 
{
    UpdateBasePosition();
    Draw();
}


void InitFighter(byte x, byte y)
{
    FighterX = x >> 1;
    FighterY = y >> 1;
    FighterDirection = 0;
    numerator = 100;
    denominator = 0;
    FighterDyingCount = -1;
    Locate();
}


static void Destroy()
{
    // Sound_LargeBang();
    StartBang(FighterX, FighterY, true);
    HideSprite(Sprite_Fighter);
    Sound_Loose();
    FighterDyingCount = 60;
}

static bool Hit()
{
    if (HitBarrier(FighterX, FighterY, HalfSize)) {
        end:
        Destroy();
        return true;
    }
    if (HitFort(FighterX, FighterY, HalfSize)) {
        goto end;
    }
    if (HitItem(FighterX, FighterY, HalfSize)) {
        Sound_Up();
        ++RemainCount;
        PrintRemain();
    }
    return false;
}

void ControlFighter()
{
    byte key, keyDirection;

    if (FighterDyingCount >= 0) return;
    key = ScanKeys();
    if ((key & Keys_Up) != 0) {
        if ((key & Keys_Right) != 0) {
            keyDirection = Direction_UpRight;
        }
        else if ((key & Keys_Left) != 0) {
            keyDirection = Direction_UpLeft;
        }
        else {
            keyDirection = Direction_Up;
        }
    }
    else if ((key & Keys_Down) != 0) {
        if ((key & Keys_Right) != 0) {
            keyDirection = Direction_DownRight;
        }
        else if ((key & Keys_Left) != 0) {
            keyDirection = Direction_DownLeft;
        }
        else {
            keyDirection = Direction_Down;
        }
    }
    else if ((key & Keys_Right) != 0) {
        keyDirection = Direction_Right;
    }
    else if ((key & Keys_Left) != 0) {
        keyDirection = Direction_Left;
    }
    else {
        keyDirection = FighterDirection;
    }
    
    FighterDirection = NewDirection(FighterDirection, keyDirection);
    numerator = (FighterDirection & 1) == 0 ? 100 : 70;
    Draw();

    StartFighterBullet((key & Keys_Button0) != 0);
}


void MoveFighter()
{
    if (FighterDyingCount >= 0)  {
        --FighterDyingCount;
        return;
    }
    if ((Clock & 7) != 0) return;
    denominator -= numerator;
    if (denominator < 0) {
        ptr<Direction> pDirection;

        DrawFighterOnRader();

        pDirection = Directions + FighterDirection;
        FighterDx = pDirection->dx;
        FighterDy = pDirection->dy;
        FighterX = AddX(FighterX, FighterDx);
        FighterY = AddY(FighterY, FighterDy);
        if (Hit()) {
            return;
        }
        Locate();
        DrawFighterOnRader();

        denominator += 100;
    }
}


bool HitFighter(byte x, byte y, byte size)
{
    if (FighterDyingCount >= 0)  return false;

    if (HitMover(FighterX, FighterY, HalfSize, x, y, size)) {
        Destroy();
        return true;    
    }
    return false;
}
