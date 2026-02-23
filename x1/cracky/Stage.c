#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "VVram.h"
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


static word DrawCell(word vram, byte b, byte y)
{
    {
        ptr<byte> p;
        byte offset;
        offset = b & 0xc;
        offset = (offset >> 1) + offset;
        p = UpperChars + offset;
        repeat (3) {
            if (y < VVramHeight) {
                repeat (2) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            else {
                p += 2;
                vram += VramRowSize;
            }
            ++y;
        }
    }
    vram -= VramRowSize;
    --y;
    {
        ptr<byte> p;
        byte offset;
        offset = b & 0x3;
        offset <<= 2; 
        p = LowerChars + offset;
        {
            if (y < VVramHeight) {
                repeat (2) {
                    byte c;
                    c = *p; ++p;
                    if (c != Char_Space) {
                        vram = Put(vram, c);
                    }
                    else {
                        vram += VramStep;
                    }
                }
                vram += VramRowSize - 2 * VramStep;
            }
            else {
                p += 2;
                vram += VramRowSize;
            }
            ++y;
        }
        {
            if (y < VVramHeight) {
                repeat (2) {
                    byte c;
                    c = *p; ++p;
                    vram = Put(vram, c);
                }
                vram += -VramRowSize * (FloorHeight - 1);
            }
            else {
                p += 2;
                vram += -VramRowSize * (FloorHeight - 1) + 2 * VramStep;
            }
            ++y;
        }
    }
    return vram;
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
    ClearVVram();

    CopyMemory(CellMap, pStageBytes, ColumnCount / ColumnsPerByte * FloorCount);
    {
        ptr<byte> pByte;
        word vram;
        byte y;
        pByte = pStageBytes;
        vram = Vram;
        y = 0;
        repeat (FloorCount) {
            repeat (ColumnCount / ColumnsPerByte) {
                byte b;
                b = *pByte; ++pByte;
                repeat (ColumnsPerByte) {
                    vram = DrawCell(vram, b, y);
                    b >>= (8 / ColumnsPerByte);
                }
            }
            vram += VramRowSize * FloorHeight - StageWidth * VramStep;
            y += FloorHeight;
        }
    }
    InitMan();
    InitMonsters();
    InitDestructions();
    // UpdateSprites();
    // VVramChanged = true;
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