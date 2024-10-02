#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Status.h"
#include "CopyMemory.h"
#include "Man.h"
#include "Monster.h"
#include "Destruction.h"

extern void _deb();

ptr<Stage> pStage;
ptr<byte> pStageBytes;
byte[ColumnCount / ColumnsPerByte * FloorCount] CellMap;

static const byte[] UpperChars = {
    Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, Char_Space,
    Char_Space, Char_Space, Char_Space, Char_Space, Char_Space, Char_Space,
    0x54, 0x51, 0x54, 0x51, 0x54, 0x51, 
    Char_Space, Char_Space, 0x28, 0x82, 0x82, 0x28,
};
static const byte[] LowerChars = {
    Char_Space, Char_Space, Char_Space, Char_Space, 
    Char_Space, Char_Space, 0x54, 0x15,
    0x54, 0x51, 0x54, 0x51, 
    Char_Space, Char_Space, 0x55, 0x55,
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
        pStageBytes = pStage->bytes;
    }
}


static ptr<byte> DrawCell(ptr<byte> pVram, byte b, byte y)
{
    {
        byte offset = b & 0xc;
        offset = (offset >> 1) + offset;
        ptr<byte> p = UpperChars + offset;
        repeat (3) {
            if (y >= StatusHeight && y < VramHeight) {
                bool right = false;
                repeat (2) {
                    pVram = Put(pVram, *p, right);
                    right = !right;
                    ++p;
                }
                pVram += VramRowSize - 1;
            }
            else {
                p += 2;
                pVram += VramRowSize;
            }
            ++y;
        }
    }
    pVram -= VramRowSize;
    --y;
    {
        byte offset = b & 0x3;
        offset <<= 2; 
        ptr<byte> p = LowerChars + offset;
        {
            if (y >= StatusHeight && y < VramHeight) {
                bool right = false;
                repeat (2) {
                    byte c = *p; ++p;
                    if (c != Char_Space) {
                        pVram = Put(pVram, c, right);
                    }
                    else if (right) {
                        ++pVram;
                    }
                    right = !right;
                }
                pVram += VramRowSize - 1;
            }
            else {
                p += 2;
                pVram += VramRowSize;
            }
            ++y;
        }
        {
            if (y >= StatusHeight && y < VramHeight) {
                bool right = false;
                repeat (2) {
                    pVram = Put(pVram, *p, right);
                    right = !right;
                    ++p;
                }
                pVram += -VramRowSize * (FloorHeight - 1);
            }
            else {
                p += 2;
                pVram += -VramRowSize * (FloorHeight - 1) + 1;
            }
            ++y;
        }
    }
    return pVram;
}

void InitTrying()
{
    {
        byte i;
        StageTime = 25;
        i = pStage->itemCount;
        do {
            StageTime += 5;
            --i;
        } while (i != 0);
    }
    ItemCount = pStage->itemCount;
    HideAllSprites();
    ClearScreen();
    PrintStatus();

    CopyMemory(CellMap, pStageBytes, ColumnCount / ColumnsPerByte * FloorCount);
    {
        ptr<byte> pByte;
        ptr<byte> pVram;
        byte y;
        pByte = pStageBytes;
        pVram = Vram + VramRowSize * StageTop;
        y = StageTop;
        repeat (FloorCount) {
            repeat (ColumnCount / ColumnsPerByte) {
                byte b;
                b = *pByte; ++pByte;
                repeat (ColumnsPerByte) {
                    pVram = DrawCell(pVram, b, y);
                    b >>= (8 / ColumnsPerByte);
                }
            }
            pVram += VramRowSize * FloorHeight - StageWidth / 2;
            y += FloorHeight;
        }
    }
    InitMan();
    InitMonsters();
    InitDestructions();
    // UpdateSprites();
    SwitchStatus(1);
    DrawAll();
}


byte GetCell(byte column, byte floor)
{
    byte b;
    b = *CellMapPtr(column, floor);
    if ((column & 1) == 0) {
        return b & 0x0f;
    }
    else {
        return b >> 4;
    }
}


void SetCell(byte column, byte floor, byte cell)
{
    ptr<byte> pCell;
    byte mask;
    pCell = CellMapPtr(column, floor);
    if ((column & 1) == 0) {
        mask = 0xf0;
        cell &= 0x0f;
    }
    else {
        mask = 0x0f;
        cell <<= 4;
    }
    *pCell = (*pCell & mask) | cell;
}
