#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Flag.h"
#include "Math.h"
#include "VVram.h"
#include "Status.h"
#include "Man.h"
#include "Monster.h"
#include "Point.h"
#include "Bang.h"
#include "Vram.h"

extern void _deb();

ptr<Stage> pStage;
byte[ColumnCount * FloorCount] StageMap;
static byte MaxTime;
sbyte Scrolling;
byte ScrollingFloor;
byte ScrollingClock;

byte ToColumn(byte b)
{
    return b >> 4;
}

byte ToFloor(byte b)
{
    return b & 0x0f;
}


void InitStage()
{
    ptr<Stage> p;
    byte i, j;
    MaxTime = 90;
    p = Stages;
    i = 0;
    j = 0;
    while (i < CurrentStage) {
        ++p;
        ++i;
        ++j;
        if (j >= StageCount) {
            p = Stages;
            j = 0;
            if (MaxTime >= 60) {
                MaxTime -= 10;
            }
        }
    }
    while (j != 0 && MaxTime < 200) {
        MaxTime += 10;
        --j;
    }
    pStage = p;
    InitFlags();
}


void InitTrying()
{
    RndIndex = 0;
    StageTime = MaxTime;
    ClearScreen();

    ptr<byte> pBytes = pStage->bytes;
    ptr<byte> pMap = StageMap;
    repeat (FloorCount) {
        repeat (ColumnCount / 4) {
            byte b = *pBytes; ++pBytes;
            repeat (4) {
                byte cell = b & 0x03;
                switch (cell) {
                case Cell_Ladder:
                    cell |= Cell_Ladder << 4;
                    break;
                case Cell_Bomb:
                    cell = (Cell_Bomb << 4) | Cell_Floor;
                    break;
                }
                *pMap = cell; ++pMap;
                b >>= 2;
            }
        }
    }
    PutFlags();
    {
        ptr<byte> pMap = StageMap;
        ptr<byte> pVVram = VVram;
        repeat (FloorCount) {
            DrawFloor(pVVram, pMap);
            pMap += ColumnCount;
            pVVram += VVramWidth * FloorHeight;
        }
    }
    Scrolling = 0;
    InitMan();
    InitMonsters();
    InitPoints();
    InitBangs();
    DrawAll();
    PrintStatus();
}


byte GetCell(byte column, byte row)
{
    byte b = *MapPtr(column, row >> 1);
    if ((row & 1) == 0) {
        b >>= 4;
        if ((b & Cell_Flag) != 0) {
            b = Cell_Blank;
        }
    }
    else {
        b &= 0x0f;
    }
    return b;
}


void MoveFloor()
{
    if (Scrolling != 0) {
        if ((ScrollingClock & CoordMask) == 0) {
            ptr<byte> pMap = MapPtr(0, ScrollingFloor);
            byte y = ScrollingFloor << FloorShift;
            ptr<byte> pVVram = VVramPtr(0, y);
            sbyte dx = 0;
            switch (Scrolling) {
            case -1:
                HitFlagsShift(-1);
                DrawFloorShift(pVVram, pMap);
                dx = -CoordRate;
                Scrolling = -2;
                break;
            case -2:
                RollLeft(pMap);
                DrawFloor(pVVram, pMap);
                dx = -CoordRate;
                Scrolling = 0;
                SlideFlags(-1);
                HitMonsters();
                break;
            case 1:
                HitFlagsShift(1);
                RollRight(pMap);
                DrawFloorShift(pVVram, pMap);
                dx = CoordRate;
                Scrolling = 2;
                break;
            case 2:
                DrawFloor(pVVram, pMap);
                dx = CoordRate;
                Scrolling = 0;
                SlideFlags(1);
                HitMonsters();
                break;
            }
            // SlideMan(dx);
        }
        ++ScrollingClock;
    }
}


void EraseBomb(byte column, byte floor)
{
    byte x = column << ColumnShift;
    byte y = floor << FloorShift;
    VErase2XY(x, y);
    *MapPtr(column, floor) &= 0x0f;
    StartBang(x << CoordShift, y << CoordShift);
}