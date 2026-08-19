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

constexpr byte Char_Debri = Char_Monster_Fall;

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
    HideAllSprites();
    ClearScreen();

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
        StageTime = 50;
        byte i = ItemCount;
        do {
            StageTime += 10;
            if (StageTime > 240) break;
            --i;
        } while (i != 0);
    }
    PrintStatus();
    InitMan();
    InitMonsters();
    InitFires();
    InitDebris();
    InitOneUp();
}


void SetCell(byte column, byte row, byte cell)
{
    static const byte[] Chars = {
        Char_Space, Char_Space, Char_Space, Char_Space, 
        Char_Floor, Char_Floor, Char_Space, Char_Space,
        Char_Ladder_Left, Char_Ladder_Right, Char_Ladder_Left, Char_Ladder_Right,
        Char_Item + 0, Char_Item + 1, Char_Item + 2, Char_Item + 3,
    };
    SetCellBits(column, row, cell);
    byte y = row << CellShift;
    if (y < WindowHeight) {
        if ((cell & Cell_Debri) != 0) {
            Put2CXY(column << CellShift, y, Char_Debri);
        }
        else {
            Put2SXY(column << CellShift, y, Chars + (cell << 2));
        }
    }
}