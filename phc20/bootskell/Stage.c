#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Status.h"
#include "Movable.h"
#include "Man.h"
#include "Block.h"
#include "Monster.h"
#include "Point.h"
#include "VVram.h"

constexpr byte MapSize = MapWidth / 4 * MapHeight;

ptr<Stage> pStage;


void InitStage() 
{
    {
        ptr<Stage> p;
        byte i, j;
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
            }
        }
        pStage = p;
    }
    InitMonsters();
}


void InitTrying()
{
    CopyMemory(CellMap, pStage->bytes, MapSize);
    {
        byte i;
        StageTime = 60;
        i = pStage->enemyCount;
        do {
            StageTime += 30;
            --i;
        } while (i != 0);
    }
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    InitMan();
    InitBlocks();
    StartMonsters();
    InitPoints();
    DrawAll();
}


byte GetCell(byte x, byte y)
{
    byte xMod, b;
    if (x >= MapWidth || y >= MapHeight) return Cell_Wall;
    b = *CellMapPtr(x, y);
    xMod = x & 3;
    if (xMod != 0) {
        do {
            b >>= 2;
            --xMod;
        } while (xMod != 0);
    }
    return b & Cell_Mask;
}


void SetCell(byte x, byte y, byte b)
{
    ptr<byte> pMap;
    byte xMod, mask;
    pMap = CellMapPtr(x, y);
    mask = 0xfc;
    xMod = x & 3;
    if (xMod != 0) {
        do {
            b <<= 2;
            mask = (mask << 2) | 3;
            --xMod;
        } while (xMod != 0);
    }
    *pMap = (*pMap & mask) | b;
}
