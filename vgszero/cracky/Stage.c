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
    Char_Ladder + 0, Char_Ladder + 1, Char_Ladder + 0, Char_Ladder + 1, Char_Ladder + 0, Char_Ladder + 1, 
    Char_Space, Char_Space, Char_Item + 0, Char_Item + 1, Char_Item + 2, Char_Item + 3,
};
static const byte[] LowerChars = {
    Char_Space, Char_Space, Char_Space, Char_Space, 
    Char_Space, Char_Space, Char_CrackedFloor + 0, Char_CrackedFloor + 1,
    Char_Ladder + 0, Char_Ladder + 1, Char_Ladder + 0, Char_Ladder + 1, 
    Char_Space, Char_Space, Char_HardFloor, Char_HardFloor,
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
        ptr<byte> p;
        byte offset;
        offset = b & 0xc;
        offset = (offset >> 1) + offset;
        p = UpperChars + offset;
        repeat (3) {
            if (y < VramHeight) {
                repeat (2) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 2 * VramStep;
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
        ptr<byte> p;
        byte offset;
        offset = b & 0x3;
        offset <<= 2; 
        p = LowerChars + offset;
        {
            if (y < VramHeight) {
                repeat (2) {
                    byte c;
                    c = *p; ++p;
                    if (c != Char_Space) {
                        pVram = Put(pVram, c);
                    }
                    else {
                        pVram += VramStep;
                    }
                }
                pVram += VramRowSize - 2 * VramStep;
            }
            else {
                p += 2;
                pVram += VramRowSize;
            }
            ++y;
        }
        {
            if (y < VramHeight) {
                repeat (2) {
                    byte c;
                    c = *p; ++p;
                    pVram = Put(pVram, c);
                }
                pVram += -VramRowSize * (FloorHeight - 1);
            }
            else {
                p += 2;
                pVram += -VramRowSize * (FloorHeight - 1) + 2 * VramStep;
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
        ptr<byte>pByte = pStageBytes;
        ptr<byte> pVram = VramBack + VramRowSize * StageTop;
        byte y = StageTop;
        repeat (FloorCount) {
            repeat (ColumnCount / ColumnsPerByte) {
                byte b;
                b = *pByte; ++pByte;
                repeat (ColumnsPerByte) {
                    pVram = DrawCell(pVram, b, y);
                    b >>= (8 / ColumnsPerByte);
                }
            }
            pVram += VramRowSize * FloorHeight - StageWidth * VramStep;
            y += FloorHeight;
        }
    }
    InitMan();
    InitMonsters();
    InitDestructions();
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


void ShowStage()
{
    sbyte x;
    x = HScroll;
    while (HScroll < 8) {
        ++HScroll;
        WaitTimer(5);
    }
    while (HScroll > -8) {
        --HScroll;
        WaitTimer(5);
    }
    while (HScroll < x) {
        ++HScroll;
        WaitTimer(5);
    }
}