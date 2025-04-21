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

ptr<Stage> pStage;
byte[ColumnCount * FloorCount] CellMap;

                extern ptr<byte> DrawCell(ptr<byte> pVram, byte b);
void DrawCellCR(byte column, byte row)
{
    row &= 0xfe;
    byte b = *CellMapPtr(column, row);
    byte y = row << CellShift;
    DrawCell(VramPtr(column << CellShift, y), b);
}

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


static ptr<byte> DrawCell(ptr<byte> pVram, byte b)
{
    static const byte[] LadderChars = {
        Char_Ladder + 0, Char_Ladder + 1, Char_Ladder + 0, Char_Ladder + 1,
    };
    static const byte[] FloorChars = {
        Char_Floor, Char_Floor, Char_Space, Char_Space,
    };
    static const byte[] FloorLadderChars = {
        Char_Floor, Char_Floor, Char_Ladder + 0, Char_Ladder + 1,
    };
    if ((b & Cell_Block) != 0) {
        Put2C(pVram, Char_Block);
    }
    else if ((b & Cell_Ceiling) != 0) {
        Put2S(pVram, FloorChars);
    }
    else if ((b & (Cell_Down | Cell_Up)) != 0) {
        Put2S(pVram, LadderChars);
    }
    else {
        Erase2(pVram);
    }
    pVram += VramRowSize * CellSize;
    b >>= 4;
    if ((b & Cell_Block) != 0) {
        Put2C(pVram, Char_Block);
    }
    else if ((b & Cell_Item) != 0) {
        Put2C(pVram, Char_Item);
    }
    else if ((b & (Cell_Down | Cell_Up)) != 0) {
        Put2S(pVram, LadderChars);
    }
    else {
        Erase2(pVram);
    }
    return pVram + CellSize * VramStep - VramRowSize * CellSize;
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
        repeat (FloorCount) {
            repeat (ColumnCount) {
                byte cell = *pCell; ++pCell;
                pVram = DrawCell(pVram, cell);
            }
            pVram += VramRowSize * FloorHeight - ColumnCount * ColumnWidth * VramStep;
        }
        repeat (ColumnCount * ColumnWidth) {
            pVram = Put(pVram, Char_Floor);
        }
    }
    InitMan();
    InitMonsters();
    InitPoints();
    UpdateSprites();
}


byte GetCell(byte column, byte row)
{
    byte b = *CellMapPtr(column, row);
    if ((row & 1) != 0) {
        b >>= 4;
    }
    return b & 0x0f;
}


