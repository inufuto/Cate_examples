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


constexpr byte InitialX = 2;
constexpr byte InitialY = 2;
constexpr byte RangeX = (StageWidth - 2);
constexpr byte RangeY = (StageHeight - 2);
constexpr byte CrashTime = 7;
constexpr byte ReviveTime = 31;
constexpr byte ReviveMask = 1;

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
    Start();
}


static void Crash()
{
    Sound_LargeBang();
    // Sound_Loose();
    StartLargeBang(MyFighter.x + 1, MyFighter.y + 1);
    HideSprite(Sprite_MyFighter);
    crashCount = CrashTime;
}


void MoveMyFighter()
{
    byte key;
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
    key = ScanKeys();
    if ((MyFighter.clock & 1) == 0) {
        MyFighterDy = 0;
        pattern = Pattern_MyFighter_Right;
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
        if (MyFighter.y + 2 > GroundY(MyFighter.x + 1)) {
            Crash();
        }
        if (HitBulletFort(MyFighter.x, MyFighter.y)) {
            Crash();
        }
    }
    StartMyBullet((key & Keys_Button0) != 0);
    if (reviveCount != 0) {
        --reviveCount;
    }
    Show();
    exit:
    ++MyFighter.clock;
}


bool HitBulletMyFighter(byte x, byte y)
{
    if (crashCount == 0 && reviveCount == 0) {
        byte xx, yy;
        xx = MyFighter.x << BulletShift;
        yy = MyFighter.y << BulletShift;
        if (
            x >= xx + 1 && x < xx + 3 &&
            y >= yy + 0 && y < yy + 3
        ) {
            Crash();
            return true;
        }
    }
    return false;
}


bool HitMovableMyFighter(byte x, byte y)
{
    if (
        crashCount == 0 && reviveCount == 0 && 
        x + 1 >= MyFighter.x &&
        x < MyFighter.x + 1 * 2 &&
        y + 1 >= MyFighter.y &&
        y < MyFighter.y + 1 * 2
    ) {
        Crash();
        return true;
    }
    else {
        return false;
    }
}
