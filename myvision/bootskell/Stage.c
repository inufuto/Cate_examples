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

constexpr byte MapSize = MapWidth / 4 * MapHeight;

ptr<Stage> pStage;
byte[MapSize] CellMap;

static const byte[] CellChars = {
    Char_Space, Char_Space, Char_Space, Char_Space, 
    Char_Block + 0, Char_Block + 1, Char_Block + 2, Char_Block + 3,
    Char_Wall + 0, Char_Wall + 1, Char_Wall + 2, Char_Wall + 3,
};


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
    UpdateSprites();
    ClearScreen();
    PrintStatus();
    {
        ptr<byte> pBytes;
        word vram;
        pBytes = CellMap;
        vram = Vram + VramWidth * StageTop;
        repeat (MapHeight) {
            repeat (MapWidth / 4) {
                byte sourceByte;
                sourceByte = *pBytes;
                repeat (4) {
                    byte b;
                    b = sourceByte & Cell_Mask;
                    Put2S(vram, CellChars + (b << 2));
                    vram += 2;
                    sourceByte >>= 2;
                }
                ++pBytes;
            }
            vram += VramWidth * 2 - MapWidth * 2;
        }
    }
    InitMan();
    InitBlocks();
    StartMonsters();
    InitPoints();
    UpdateSprites();
}


static ptr<byte> CellMapPtr(byte x, byte y)
{
    return CellMap + ((y << 2) + (x >> 2));
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
    Put2S(VramAddress(x << 1, (y << 1) + StageTop), CellChars + (b << 2));
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
}
