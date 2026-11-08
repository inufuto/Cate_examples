#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Math.h"
#include "Chars.h"
#include "Vram.h"
#include "Status.h"
#include "Man.h"
#include "Monster.h"
#include "Fire.h"
#include "Debri.h"
#include "Sprite.h"
#include "OneUp.h"

byte[MapWidth * RowCount] StageMap;
ptr<Stage> pStage;
byte ItemCount;

void InitStage() 
{
    FireTime = RowHeight * RowCount;
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
            --FireTime;
            if (FireTime < RowHeight * 2) {
                FireTime = RowHeight * 2;
            }
        }
    }
    pStage = p;
}


void InitTrying()
{
    RndIndex = 0;
    ItemCount = 0;
    ClearScreen();
    HideAllSprites();

    ptr<byte> pUpper = pStage->bytes;
    ptr<byte> pLower = pUpper + ColumnCount / 4;
    byte row = 0;
    repeat (FloorCount) {
        byte column = 0;
        repeat (ColumnCount / 4) {
            byte upper = *pUpper; ++pUpper;
            byte lower;
            if (row < RowCount - 2) {
                lower = *pLower; ++pLower;
            }
            else {
                lower = 0;
            }
            repeat (4) {
                byte upperCell;
                byte lowerCell;
                switch (upper & 0x03) {
                case Source_Floor:
                    upperCell = Cell_Space;
                    lowerCell = Cell_Floor;
                    break;
                case Source_Ladder:
                    upperCell = Cell_Ladder;
                    lowerCell = Cell_Floor;
                    break;
                case Source_Item:
                    upperCell = Cell_Item;
                    lowerCell = Cell_Floor;
                    ++ItemCount;
                    break;
                default:
                    upperCell = Cell_Space;
                    lowerCell = Cell_Space;
                    break;
                }
                if ((lower & 0x03) == Source_Ladder) {
                    upperCell = Cell_Ladder;
                    lowerCell = Cell_Ladder;
                }
                SetCell(column, row, upperCell);
                SetCell(column, row + 1, lowerCell);
                upper >>= 2;
                lower >>= 2;
                ++column;
            }
        }
        row += 2;
    }
    {
        StageTime = 50 * 3 / 4;
        byte i = ItemCount;
        do {
            StageTime += 10 * 3 / 4;
            if (StageTime > 240 * 3 / 4) break;
            --i;
        } while (i != 0);
    }
    PrintStatus();
    InitMan();
    InitMonsters();
    InitFires();
    InitDebris();
    InitOneUp();
    SwitchStatus(1);
    DrawAll();
}


void SetCell(byte column, byte row, byte cell)
{
    SetCellBits(column, row, cell);
    byte y = row << CellShift;
    if (y < WindowHeight) {
        ptr<byte> pChars;
        if ((cell & Cell_Debri) != 0) {
            static const byte[] Chars = {
                0x2a, 0x8a, 0x9a, 0x9a,
            };
            pChars = Chars;
        }
        else {
            static const byte[] Chars = {
                0x00, 0x00, 0x00, 0x00, 
                0x50, 0x50, 0x00, 0x00,
                0x54, 0x51, 0x54, 0x51,
                0x3c, 0xc3, 0xc3, 0x3c,
            };
            pChars = Chars + (cell << 2);
        }
        Put2SXY(column << CellShift, y, pChars);
    }
}