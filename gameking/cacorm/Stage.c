#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Movable.h"
#include "Actor.h"
#include "Sprite.h"
#include "Chars.h"
#include "CopyMemory.h"
#include "Status.h"
#include "Man.h"
#include "Item.h"
#include "Monster.h"
#include "Point.h"
#include "Increaser.h"

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[MapWidth * MapHeight] CellMap;

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
        pStageBytes = pStage->bytes;
    }
    InitItems();
    InitMonsters();
}


void InitTrying()
{
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
    // UpdateSprites();
    ClearScreen();
    PrintStatus();
    {
        ptr<byte> pCell, pByte;
        byte b, count;
        pCell = CellMap;
        pByte = pStageBytes;
        ptr<byte> pVram = Vram + VramRowSize * StageTop;
        b = *pByte;
        ++pByte;
        count = 8;
        repeat (MapHeight) {
            repeat (MapWidth) {
                byte cell;
                if ((b & 1) != 0) {
                    static const byte[] Chars = {
                        0xa9, 0xa6, 0x9a, 0x6a,
                    };
                    cell = Cell_Wall;
                    pVram = Put2S(pVram, Chars, false);
                }
                else {
                    cell = Cell_Space;
                    pVram = Erase2(pVram, false);
                }
                *pCell = cell;
                ++pCell;
                b >>= 1;
                --count;
                if (count == 0) {
                    b = *pByte;
                    ++pByte;
                    count = 8;
                }
            }
            pVram += VramRowSize * 2 - MapWidth;
        }
    }
    InitMan();
    DrawItems();
    StartMonsters();
    InitPoints();
    InitIncreaser();
    PresentVram();
}


byte GetCell(byte x, byte y)
{
    byte xMod, b;
    if (x >= MapWidth || y >= MapHeight) return Cell_Wall;
    return *CellMapPtr(x, y);
}
