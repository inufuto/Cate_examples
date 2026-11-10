#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Status.h"
#include "Block.h"
#include "Man.h"
#include "Monster.h"
#include "CopyMemory.h"
#include "Point.h"
#include "Math.h"

extern void _deb();

constexpr byte Char_Floor = 0x50;
constexpr byte Char_Ladder0 = 0x54;
constexpr byte Char_Ladder1 = 0x51;

ptr<Stage> pStage;
byte[ColumnCount * FloorCount] CellMap;

void InitStage() 
{
    {
        ptr<Stage> p = Stages;
        byte i = 0;
        byte j = 0;
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
}


static ptr<byte> DrawCell(ptr<byte> pVram, byte b, byte y)
{
    static const byte [] SpaceChars = {
        Char_Space, Char_Space, Char_Space, Char_Space,
    };
    static const byte[] ItemChars = {
        0x3c, 0xc3, 0xc3, 0x3c, 
    };
    static const byte[] LadderChars = {
        Char_Ladder0, Char_Ladder1, Char_Ladder0, Char_Ladder1,
    };
    static const byte[] FloorChars = {
        Char_Floor, Char_Floor, Char_Space, Char_Space,
    };
    static const byte[] FloorLadderChars = {
        Char_Floor, Char_Floor, Char_Ladder0, Char_Ladder1,
    };
    
    ptr<byte> pUpperChars;
    if ((y - StageTop) < VramHeight - StageTop) {
        if ((b & Cell_Block) != 0) {
            pUpperChars = BlockChars;
        }
        else if ((b & Cell_Ceiling) != 0) {
            pUpperChars = FloorChars;
        }
        else if ((b & (Cell_Down | Cell_Up)) != 0) {
            pUpperChars = LadderChars;
        }
        else {
            pUpperChars = SpaceChars;
        }
        Put2S(pVram, pUpperChars, false);
    }
    pVram += VramRowSize * CellSize;
    
    {
        ptr<byte> pLowerChars;
        b >>= 4;
        if ((b & Cell_Block) != 0) {
            pLowerChars = BlockChars;
        }
        else if ((b & Cell_Item) != 0) {
            pLowerChars = ItemChars;
        }
        else if ((b & (Cell_Down | Cell_Up)) != 0) {
            pLowerChars = LadderChars;
        }
        else {
            pLowerChars = SpaceChars;
        }
        Put2S(pVram, pLowerChars, false);
    }
    return pVram + CellSize / 2 - VramRowSize * CellSize;
}


void InitTrying()
{
    RndIndex = 0;
    ItemCount = 0;
    {
        FillMemory(CellMap, ColumnCount * FloorCount, 0);

        constexpr byte Mask = 3;
        constexpr byte Floor = 1;
        constexpr byte Ladder = 2;
        constexpr byte Item = 3;

        byte floor = 0;
        ptr<byte> pCell = CellMap;
        ptr<byte> pUpper = pStage->bytes;
        ptr<byte> pLower = pUpper + ColumnCount / ColumnsPerByte;
        repeat (FloorCount) {
            repeat (ColumnCount / ColumnsPerByte) {
                byte upper = *pUpper; ++pUpper;
                byte lower = *pLower; ++pLower;
                repeat (ColumnsPerByte) {
                    byte bits = upper & Mask;
                    if (bits == Floor && floor < FloorCount - 1) {
                        pCell[ColumnCount] |= Cell_Ceiling;
                    }
                    if (bits == Ladder) {
                        *pCell |= (Cell_Up | Cell_Down) | (Cell_Up << 4);
                        if (floor < FloorCount - 1) {
                            pCell[ColumnCount] |= Cell_Ceiling;
                        }
                    }
                    if (floor < FloorCount - 1 && (lower & Mask) == Ladder) {
                        *pCell |= Cell_Down << 4;
                        if (floor < FloorCount - 1) {
                            pCell[ColumnCount] &= ~Cell_Ceiling;
                        }
                    }
                    if (bits == Item) {
                        *pCell |= Cell_Item << 4;
                        if (floor < FloorCount - 1) {
                            pCell[ColumnCount] |= Cell_Ceiling;
                        }
                        ++ItemCount;
                    }
                    ++pCell;
                    upper >>= 2;
                    lower >>= 2;
                }
            }
            ++floor;
        }
    }
    {
        StageTime = 40;
        byte i = ItemCount;
        do {
            StageTime += 8;
            if (StageTime > 240) break;
            --i;
        } while (i != 0);
    }
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    InitBlocks();
    {
        ptr<byte> pCell = CellMap;
        ptr<byte> pVram = Vram;
        byte y = 0;
        repeat (FloorCount) {
            repeat (ColumnCount) {
                byte cell = *pCell; ++pCell;
                pVram = DrawCell(pVram, cell, y);
            }
            y += FloorHeight;
            pVram += VramRowSize * FloorHeight - ColumnCount * ColumnWidth / 2;
        }
    }
    InitMan();
    InitMonsters();
    InitPoints();
}


byte GetCell(byte column, byte row)
{
    byte b = *CellMapPtr(column, row);
    if ((row & 1) != 0) {
        b >>= 4;
    }
    return b & 0x0f;
}


void DrawCellCR(byte column, byte row)
{
    row &= 0xfe;
    byte b = *CellMapPtr(column, row);
    byte y = row << CellShift;
    DrawCell(Vram + VramOffset(column << CellShift, y), b, y);
}