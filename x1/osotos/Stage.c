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
#include "VVram.h"

extern void _deb();

ptr<Stage> pStage;
byte[ColumnCount * FloorCount] CellMap;
bool BackgroundChanged;

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


static word DrawCell(word vram, byte b)
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
        Put2C(vram, Char_Block);
    }
    else if ((b & Cell_Ceiling) != 0) {
        Put2S(vram, FloorChars);
    }
    else if ((b & (Cell_Down | Cell_Up)) != 0) {
        Put2S(vram, LadderChars);
    }
    else {
        Erase2(vram);
    }
    vram += VramRowSize * CellSize;
    b >>= 4;
    if ((b & Cell_Block) != 0) {
        Put2C(vram, Char_Block);
    }
    else if ((b & Cell_Item) != 0) {
        Put2C(vram, Char_Item);
    }
    else if ((b & (Cell_Down | Cell_Up)) != 0) {
        Put2S(vram, LadderChars);
    }
    else {
        Erase2(vram);
    }
    return vram + CellSize * VramStep - VramRowSize * CellSize;
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
        word vram = Vram;
        repeat (FloorCount) {
            repeat (ColumnCount) {
                byte cell = *pCell; ++pCell;
                vram = DrawCell(vram, cell);
            }
            vram += VramRowSize * FloorHeight - VVramWidth * VramStep;
        }
        repeat (VVramWidth) {
            vram = Put(vram, Char_Floor);
        }
    }
    InitMan();
    InitMonsters();
    InitPoints();
    DrawAll();
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
    DrawCell(VramAddress(column << CellShift, y), b);
    BackgroundChanged = true;
}