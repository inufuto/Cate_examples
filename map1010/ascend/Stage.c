#include "Vram.h"
#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Chars.h"
#include "Status.h"
#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fire.h"
#include "Monster.h"
#include "Block.h"
#include "Math.h"
#include "VVram.h"

constexpr byte VisibleFloorCount = (WindowHeight + FloorHeight - 1) / FloorHeight + 1;
constexpr word VramTop = Vram + VramRowSize * StatusHeight;
constexpr byte MapWidth = ColumnCount / 4;

ptr<Stage> pStage;
byte[MapWidth * MaxMapHeight] StageMap;
static byte timeRate;

byte topY, topRow, yMod, topYRange;
byte[WindowWidth * VisibleFloorCount * FloorHeight] Background;

extern void _deb();
void InitStage() 
{
    {
        ptr<Stage> p;
        byte i, j;
        p = Stages;
        i = 0;
        j = 0;
        timeRate = 10;
        while (i < CurrentStage) {
            ++p;
            ++i;
            ++j;
            if (j >= StageCount) {
                p = Stages;
                j = 0;
                if (timeRate != 0) {
                    --timeRate;
                }
            }
        }
        pStage = p;
    }
    {
        ptr<byte> pBytes, pMap;
        byte yCount, xCount, b, d, spaceCount, shiftCount;
        yCount = pStage->height;
        pBytes = pStage->pBytes;
        pMap = StageMap;
        d = 0;
        shiftCount = 0;
        xCount = ColumnCount;
        do {
            b = *pBytes; ++pBytes;
            spaceCount = b >> 2;
            while (spaceCount != 0) {
                d >>= 2;
                ++shiftCount;
                if (shiftCount >= 4) {
                    *pMap = d; ++pMap;
                    d = 0;
                    shiftCount = 0;
                }
                --spaceCount;
                --xCount;
            }
            d >>= 2;
            d |= (b & CellType_Mask) << 6;
            ++shiftCount;
            if (shiftCount >= 4) {
                *pMap = d; ++pMap;
                d = 0;
                shiftCount = 0;
            }
            --xCount;
            if (xCount == 0) {
                --yCount;
                xCount = ColumnCount;
            }
        } while (yCount != 0);
    }
}


void InitTrying()
{
    byte i;
    StageTime = 100;
    i = pStage->height;
    do {
        StageTime += timeRate;
        --i;
    } while (i != 0);

    HideAllSprites();
    // UpdateSprites();
    ClearScreen();
    PrintStatus();
    topY = (pStage->height << 2) + FloorHeight - WindowHeight;
    topYRange = topY + 1;
    topRow = 0x80;
    // dotOffset = 0;
    RndIndex = 0;
    InitMan();
    InitFires();
    InitMonsters();
    InitBlocks();

    DrawBackground();
    // UpdateSprites();
    DrawAll();
}


static ptr<byte> FillTile2(ptr<byte> pBackground, ptr<byte> pChars)
{
    repeat (ColumnWidth) {
        *pBackground = *pChars;
        ++pBackground;
        ++pChars;
    }
    return pBackground + WindowWidth - ColumnWidth;
}


static ptr<byte> FillTile4(ptr<byte> pBackground, ptr<byte> pChars)
{
    repeat (FloorHeight - 2) {
        repeat (ColumnWidth) {
            *pBackground = *pChars;
            ++pBackground;
            ++pChars;
        }
        pBackground += WindowWidth - ColumnWidth;
    }
    return pBackground;
}

// void FillBackground()
// {
//     static const byte[] Spaces = {
//         Char_Space, Char_Space,
//         Char_Space, Char_Space,
//     };
//     static const byte[] Floor = {
//         Char_Space_Floor, Char_Space_Floor,
//     };
//     static const byte[] SpaceUnderFloor = {
//         Char_Floor_Space, Char_Floor_Space,
//     };
//     static const byte[] WallUnderFloor = {
//         Char_Wall_Wall, Char_Floor_Space,
//     };
//     static const byte[] SpaceLadder = {
//         Char_Space_LeftLadder, Char_Space_RightLadder,
//         Char_LeftLadder_LeftLadder, Char_RightLadder_RightLadder,
//     };
//     static const byte[] Ladder = {
//         Char_LeftLadder_LeftLadder, Char_RightLadder_RightLadder,
//         Char_LeftLadder_LeftLadder, Char_RightLadder_RightLadder,
//     };
//     static const byte[] LadderFloor = {
//         Char_LeftLadder_Floor, Char_RightLadder_Floor,
//     };
//     static const byte[] LadderWall = {
//         Char_LeftLadder_Wall, Char_RightLadder_Floor,
//     };
//     static const byte[] Wall = {
//         Char_Wall_Wall, Char_Space,
//         Char_Wall_Wall, Char_Space,
//     };
//     static const byte[] WallFloor = {
//         Char_Space_Wall, Char_Space_Floor,
//     };
//     static const byte[] WallFloorUnderWall = {
//         Char_Wall_Wall, Char_Space_Floor,
//     };
//     static const byte[] FloorUnderWall = {
//         Char_Wall_Floor, Char_Space_Floor,
//     };

//     ptr<byte> pMap, pBackground;
//     word vram;
//     byte row;
//     if ((topRow & 0x80) != 0) {
//         pMap = StageMap;
//     }
//     else {
//         pMap = StageMap + (topRow <<2);
//     }
//     pBackground = Background;
//     row = topRow;
//     repeat (VisibleFloorCount) {
//         repeat (MapWidth) {
//             byte upper, middle, lower;
//             if ((row & 0x80) != 0) {
//                 middle = 0;
//                 lower = pMap[0];
//                 upper = 0xff;
//             }
//             else {
//                 middle = pMap[0]; 
//                 lower = row + 1 < pStage->height ? pMap[MapWidth] : CellType_Space;
//                 upper = row != 0 ? pMap[-MapWidth] : CellType_Space;
//             }
//             ++pMap;
//             repeat (4) {
//                 ptr<byte> pUpper, pMiddle, pLower;
//                 switch (middle & 3) {
//                 case CellType_Space:
//                     switch (upper & 3) {
//                     case CellType_Hole:
//                         pUpper = Spaces;
//                         break;
//                     default:
//                         pUpper = SpaceUnderFloor;
//                     }
//                     switch (lower & 3) {
//                     case CellType_Ladder:
//                         pMiddle = SpaceLadder;
//                         pLower = Ladder;
//                         break;
//                     case CellType_Wall:
//                         pMiddle = Spaces;
//                         pLower = WallFloor;
//                         break;
//                     default:
//                         pMiddle = Spaces;
//                         pLower = Floor;
//                     }
//                     break;
//                 case CellType_Ladder:
//                     pUpper = Ladder;
//                     pMiddle = Ladder;
//                     switch (lower & 3) {
//                     case CellType_Ladder:
//                         pLower = Ladder;
//                         break;
//                     case CellType_Wall:
//                         pLower = LadderWall;
//                         break;
//                     default:
//                         pLower = LadderFloor;
//                     }
//                     break;
//                 case CellType_Wall:
//                     pUpper = WallUnderFloor;
//                     switch (lower & 3) {
//                     case CellType_Wall:
//                         pLower = WallFloorUnderWall;
//                         break;
//                     default:
//                         pLower = FloorUnderWall;
//                     }
//                     pMiddle = Wall;
//                     break;
//                 case CellType_Hole:
//                     switch (upper & 3) {
//                     case CellType_Hole:
//                         pUpper = Spaces;
//                         break;
//                     default:
//                         pUpper = SpaceUnderFloor;
//                     }
//                     pMiddle = Spaces;
//                     pLower = Spaces;
//                     break;
//                 }
//                 pBackground = FillTile2(pBackground, pUpper);
//                 pBackground = FillTile4(pBackground, pMiddle);
//                 pBackground = FillTile2(pBackground, pLower);
//                 pBackground += ColumnWidth - WindowWidth * FloorHeight;
//                 middle >>= 2;
//                 lower >>= 2;
//                 upper >>= 2;
//             }
//         }
//         if ((row & 0x80) != 0) {
//             pMap = StageMap;
//         }
//         pBackground += WindowWidth * (FloorHeight - 1);
//         ++row;
//     }
// }


void DrawBackground()
{
    byte newTopRow;
    yMod = topY;
    newTopRow = -1;
    while (yMod >= FloorHeight) {
        ++newTopRow;
        yMod -= FloorHeight;
    }
    if (newTopRow != topRow) {
        topRow = newTopRow;
    }
    DrawAll();
}


byte GetCellType(byte x, byte y)
{
    byte row, offset, b;
    row = (y >> FloorShift) - 1;
    if (row >= pStage->height) return 0;
    x >>= 1;
    offset = ((y - FloorHeight) & 0xfc) + (x >> 2);
    b = StageMap[offset];
    x &= 0x03;
    while (x != 0) {
        b >>= 2;
        --x;
    }
    return b & CellType_Mask;
}


bool IsOnFloor(byte y)
{
    return ((y - Overhead) & FloorMask) == 0;
}


bool IsWall(byte x, byte y)
{
    if ((x & 1) != 0) return false;
    return GetCellType(x, y) == CellType_Wall;
}


byte ToX(byte b)
{
    return (b & 0x0f) << 1;
}


byte ToY(byte b)
{
    byte y;
    y = (b & 0xf0) >> 2;
    return y + (Overhead + FloorHeight);
}
