#include "Flag.h"
#include "Stage.h"
#include "Man.h"
#include "Main.h"
#include "Sound.h"
#include "VVram.h"
#include "Point.h"
#include "Chars.h"

extern void _deb();

constexpr byte InvalidColumn = 0xff;
constexpr byte InvalidType = 0xff;

Flag[MaxFlagCount] Flags;
byte FlagCount;
static byte LastType;
static byte Rate;

void InitFlags()
{
    ptr<Flag> pFlag = Flags;
    ptr<byte> p = pStage->flags;
    repeat(MaxFlagCount) {
        byte b = *p; ++p;
        pFlag->column = ToColumn(b);
        pFlag->floor = ToFloor(b);
        ++pFlag;
    }
    LastType = InvalidType;
    Rate = 0;
}


void PutFlags()
{
    FlagCount = 0;
    byte index = 0;
    ptr<byte> p = pStage->flags;
    ptr<Flag> pFlag;
    for (pFlag : Flags) {
        byte b = *p; ++p;
        if (pFlag->column < ColumnCount) {
            pFlag->column = ToColumn(b);
            pFlag->floor = ToFloor(b);
            *MapPtr(pFlag->column, pFlag->floor) |= ((index << 3) & 0x30) | (Cell_Flag << 4);
            ++FlagCount;
        }
        ++index;
    }
}


void SlideFlags(sbyte dx)
{
    ptr<Flag> pFlag;
    for (pFlag : Flags) {
        if (pFlag->column < ColumnCount && pFlag->floor == ScrollingFloor) {
            pFlag->column = (pFlag->column + dx) & (ColumnCount - 1);
        }
    }
}


void DrawFlags()
{
    static byte clock;
    byte index = 0;
    ptr<Flag> pFlag;
    for (pFlag: Flags) {
        if (pFlag->column < ColumnCount) {
            byte type = index >> 1;
            byte x = pFlag->column << ColumnShift;
            byte y = (pFlag->floor << FloorShift);
            VPut2CXY(x, y, (type << 2) + Char_Flag);
        }
        ++index;
    }
    ++clock;
}


void BlinkFlags()
{
    static byte clock;
    byte index = 0;
    ptr<Flag> pFlag;
    for (pFlag: Flags) {
        if (pFlag->column < ColumnCount) {
            byte type = index >> 1;
            if (type == LastType) {
                byte x = pFlag->column << ColumnShift;
                byte y = (pFlag->floor << FloorShift);
                if ((clock & CoordRate) != 0) {
                    VErase2XY(x, y);
                }
                else {
                    VPut2CXY(x, y, (type << 2) + Char_Flag);
                }
            }
            PollVSync();
        }
        ++index;
    }
    ++clock;
}


static void Hit(ptr<Flag> pFlag, byte x, byte y, byte index)
{
    byte type = index >> 1;
    if (type == LastType) {
        StartPoint(x << CoordShift, y << CoordShift, Rate);
        ++Rate;
        LastType = InvalidType;
    }
    else {
        AddScore(5);
        if (LastType != InvalidType) {
            Rate = 0;
        }
        LastType = type;
    }
    *MapPtr(pFlag->column, pFlag->floor) &= 0x0f;
    pFlag->column = InvalidColumn;
    --FlagCount;
    Sound_Hit();
}

void HitFlags(byte column, byte floor)
{
    byte index = 0;
    ptr<Flag> pFlag;
    for (pFlag : Flags) {
        if (pFlag->column == column && pFlag->floor == floor) {
            byte x = pFlag->column << ColumnShift;
            byte y = pFlag->floor << FloorShift;
            Hit(pFlag, x, y, index);
            VErase2XY(x, y);
            DrawFlags();
            break;
        }
        ++index;
    }
}

void HitFlagsShift(sbyte offset)
{
    byte manX = Man.x >> CoordShift;
    if ((manX & 1) == 0) return;
    byte index = 0;
    ptr<Flag> pFlag;
    for (pFlag : Flags) {
        if (pFlag->floor == ScrollingFloor) {
            byte x = (pFlag->column << ColumnShift) + offset;
            byte y = pFlag->floor << FloorShift;
            if (x == manX && y == Man.y >> CoordShift) {
                Hit(pFlag, x, y, index);
                break;
            }
        }
        ++index;
    }
}
