#include "Map.h"
#include "CopyMemory.h"
#include "Main.h"
#include "Stages.h"
#include "Man.h"
#include "Knife.h"
#include "Monster.h"
#include "VVram.h"
#include "Chars.h"

byte StageWidth, StageHeight;
byte MapWidth, MapHeight;
byte[MapSize] Map;
byte BaseX, BaseY;
byte GoalX, GoalY;
ptr<byte> pStage;

static byte maskBit, mapByte;
static ptr<byte> pMap;

byte ToMapSize(byte a)
{
    return (a << 1) + a + 1;
}

static void RotBit()
{
    maskBit <<= 1;
    if (maskBit == 0) {
        pMap[0] = mapByte;
        ++pMap;
        mapByte = 0;
        maskBit = 1;
    }
}

static void RotBit2()
{
    maskBit <<= 1;
    if (maskBit == 0) {
        pMap[0] = mapByte;
        pMap[MapStep] = mapByte;
        ++pMap;
        mapByte = 0;
        maskBit = 1;
    }
}


void _deb(){}
void InitMap()
{
    ptr<byte> pMapRow;
    byte xCount, yCount, sourceByte, bitCount;

    FillMemory(Map, MapSize, 0);
    {
        byte count;
        TimeRate = 10;
        count = CurrentStage;
        while (count > StageCount) {
            --TimeRate;
            count -= StageCount;
        }
    }
    pStage = Stages[CurrentStage & 0x0f];
    StageWidth = *pStage; 
    MapWidth = ToMapSize(StageWidth);
    ++pStage;
    StageHeight = *pStage; 
    MapHeight = ToMapSize(StageHeight);
    ++pStage;

    pMapRow = Map;

    pMap = pMapRow;
    maskBit = 1;
    mapByte = 0;
    xCount = MapWidth;
    do {
        mapByte |= maskBit;
        RotBit();
        --xCount;
    } while (xCount != 0);
    *pMap = mapByte;
    pMapRow += MapStep;

    sourceByte = *pStage; ; ++pStage;
    bitCount = 8;
    yCount = StageHeight;
    do {
        pMap = pMapRow;
        maskBit = 1;
        mapByte = 1;
        RotBit2();
        xCount = StageWidth;
        do {
            RotBit2();
            RotBit2();
            if ((sourceByte & 1) != 0) {
                mapByte |= maskBit;
            }
            RotBit2();
            sourceByte >>= 1;
            --bitCount;
            if (bitCount == 0) {
                sourceByte = *pStage; ; ++pStage;
                bitCount = 8;
            }
            --xCount;
        } while (xCount != 0);
        pMap[0] = mapByte;
        pMap[MapStep] = mapByte;
        pMapRow += MapStep * 2;

        pMap = pMapRow;
        maskBit = 1;
        mapByte = 1;
        RotBit();
        xCount = StageWidth;
        do {
            if ((sourceByte & 1) != 0) {
                mapByte |= maskBit;
                RotBit();
                mapByte |= maskBit;
                RotBit();
            }
            else {
                RotBit();
                RotBit();
            }
            mapByte |= maskBit;
            RotBit();
            sourceByte >>= 1;
            --bitCount;
            if (bitCount == 0) {
                sourceByte = *pStage; ; ++pStage;
                bitCount = 8;
            }
            --xCount;
        } while (xCount != 0);
        *pMap = mapByte;
        
        pMapRow += MapStep;
        --yCount;
    } while (yCount != 0);
    if (bitCount == 8) {
        --pStage;
    }

    InitMan();
    GoalX = ToMapSize(*pStage); ++pStage;
    GoalY = ToMapSize(*pStage); ++pStage;
    InitKnives();
    InitMonsters();
                                _deb();
    StageTime = pStage[1] + (((word)pStage[0]) << 8);
    // {
    //     byte b;
    //     b = pStage[1];
    //     StageTime = pStage[0] + (((word)b) << 8);
    // }
}


void DrawGoal()
{
    static bool blink;
    if (blink) {
        VPut2(GoalX, GoalY, Char_Goal);
        blink = false;
    }
    else {
        blink = true;
    }
}


static ptr<byte> MapPtr(byte x, byte y)
{
    return Map + (((word)y) << 3) + (x >> 3);
}


bool CanMove1(byte x, byte y)
{
    ptr<byte> pMap;
    byte bit;
    pMap = MapPtr(x, y);
    x &= 7;
    bit = 1;
    while (x != 0) {
        bit <<= 1;
        --x;
    }
    return (pMap[0] & bit) == 0;
}


bool CanMove2(byte x, byte y)
{
    ptr<byte> pMap;
    word bit;
    byte l, h;
    pMap = MapPtr(x, y);
    x &= 7;
    bit = 3;
    while (x != 0) {
        bit <<= 1;
        --x;
    }
    l = bit;
    h = bit >> 8;
    return 
        (pMap[0] & l) == 0 &&
        (pMap[1] & h) == 0 &&
        (pMap[MapStep + 0] & l) == 0 &&
        (pMap[MapStep + 1] & h) == 0;
}
