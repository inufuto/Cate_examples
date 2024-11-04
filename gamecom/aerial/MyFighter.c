#include "MyFighter.h"
#include "Stage.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "MyBullet.h"
#include "Sound.h"
#include "Bang.h"
#include "Status.h"
#include "Main.h"
#include "Fort.h"

constexpr byte InitialX = 2 * CoordRate;
constexpr byte InitialY = 2 * CoordRate;
constexpr byte RangeX = (StageWidth - 2) * CoordRate;
constexpr byte RangeY = (StageHeight - 2) * CoordRate;
constexpr byte CrashTime = 7 * CoordRate;
constexpr byte ReviveTime = 31 * CoordRate;
constexpr byte ReviveMask = CoordRate;

Movable MyFighter;
sbyte MyFighterDy;
static byte pattern;
static byte crashCount;
static byte reviveCount;


static void Show()
{
    if (
        crashCount != 0 ||
        (reviveCount != 0 && (MyFighter.clock & ReviveMask) == 0)
    ) {
        HideSprite(Sprite_MyFighter);
    }
    else {
        ShowFighter(&MyFighter, pattern);
    }
}


static void Start()
{
    MyFighter.x = InitialX;
    MyFighter.y = InitialY;
    pattern = Pattern_MyFighter_Right;
    MyFighterDy = 0;
    crashCount = 0;
    Show();
}


void InitMyFighter()
{
    MyFighter.sprite = Sprite_MyFighter;
    MyFighter.clock = 0;
    reviveCount = 0;
    crashCount = 0;
    Start();
}


static void Crash()
{
    // Sound_LargeBang();
    Sound_Loose();
    StartLargeBang(MyFighter.x + CoordRate, MyFighter.y + CoordRate);
    HideSprite(Sprite_MyFighter);
    crashCount = CrashTime;
}


void MoveMyFighter()
{
    if (crashCount != 0) {
        if (--crashCount == 0) {
            if (--RemainCount != 0) {
                PrintStatus();
                reviveCount = ReviveTime;
                Start();
            }
        }
        goto exit;
    }
    if ((MyFighter.clock & 1) == 0) {
        byte key;
        MyFighterDy = 0;
        pattern = Pattern_MyFighter_Right;
        key = ScanKeys();
        if ((key & Keys_Left) != 0 && MyFighter.x > 0) {
            --MyFighter.x;
        }
        if ((key & Keys_Right) != 0 && MyFighter.x < RangeX) {
            ++MyFighter.x;
        }
        if ((key & Keys_Up) != 0 && MyFighter.y > 0) {
            --MyFighter.y;
            MyFighterDy = -1;
            pattern = Pattern_MyFighter_RightUp;
        }
        if ((key & Keys_Down) != 0 && MyFighter.y < RangeY) {
            ++MyFighter.y;
            MyFighterDy = 1;
            pattern = Pattern_MyFighter_RightDown;
        }
        if (MyFighter.y + CoordRate * 3 / 2 > GroundY(MyFighter.x + CoordRate)) {
            Crash();
        }
        StartMyBullet((key & Keys_Button0) != 0);
        if (HitBulletFort(MyFighter.x, MyFighter.y)) {
            Crash();
        }
    }
    if (reviveCount != 0) {
        --reviveCount;
    }
    Show();
    exit:
    ++MyFighter.clock;
}


bool HitBulletMyFighter(byte x, byte y)
{
    constexpr byte Range = CoordRate / 4;
    if (
        crashCount == 0 && reviveCount == 0 && 
        x + Range >= MyFighter.x &&
        x < MyFighter.x + (CoordRate + Range) &&
        y + Range >= MyFighter.y &&
        y < MyFighter.y + (CoordRate + Range)
    ) {
        Crash();
        return true;
    }
    else {
        return false;
    }
}


bool HitMovableMyFighter(byte x, byte y)
{
    constexpr byte Range = CoordRate;
    if (
        crashCount == 0 && reviveCount == 0 && 
        x + Range >= MyFighter.x &&
        x < MyFighter.x + Range &&
        y + Range >= MyFighter.y &&
        y < MyFighter.y + Range
    ) {
        Crash();
        return true;
    }
    else {
        return false;
    }
}
