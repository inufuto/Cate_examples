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
#include "Rader.h"

constexpr byte FixedX = VVramWidth / 2 * 8 - 8;
constexpr byte FixedY = VVramHeight / 2 * 8 - 8;
constexpr byte Size = 2;

byte FighterX, FighterY;
sbyte FighterDx, FighterDy;
byte FighterDirection;
static sbyte numerator, denominator;
sbyte FighterDyingCount;

static void Locate() 
{
    UpdateBasePosition();
    ShowSprite(Sprite_Fighter, FixedX / 2, FixedY / 2, Pattern_Fighter + FighterDirection);
    // ShowSprite(Sprite_MapPoint, 8 * 24 - 1 + (FighterX >> 1), 8 * 12 - 1 + (FighterY >> 1), 
    //     Pattern_FighterOnMap, SpriteColor);
}


void InitFighter(byte x, byte y)
{
    FighterX = x;
    FighterY = y;
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
    HideSprite(Sprite_MapPoint);
    Sound_Loose();
    FighterDyingCount = 60;
}

static bool Hit()
{
    if (HitBarrier(FighterX, FighterY, 0)) {
        end:
        Destroy();
        return true;
    }
    if (HitFort(FighterX, FighterY, 0)) {
        goto end;
    }
    if (HitItem(FighterX, FighterY, 0)) {
        Sound_Up();
        ++RemainFighterCount;
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
    StartFighterBullet((key & Keys_Button0) != 0);
}


void MoveFighter()
{
    if (FighterDyingCount >= 0)  {
        --FighterDyingCount;
        return;
    }
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

    if (HitMover(FighterX, FighterY, Size, x, y, size)) {
        Destroy();
        return true;    
    }
    return false;
}
