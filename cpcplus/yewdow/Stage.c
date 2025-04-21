#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Sprite.h"
#include "Vram.h"
#include "Status.h"
#include "Man.h"
#include "Chars.h"
#include "Car.h"
#include "Monster.h"
#include "Item.h"
#include "Point.h"

extern void _deb();

constexpr ptr<byte> VramTop = Vram + VramRowSize * StageTop;
ptr<Stage> pStage;
byte[MapWidth / MapWidthPerByte * MapHeight] CellMap;
static byte MaxTime;

void InitStage()
{
    ptr<Stage> p;
    byte i, j;
    MaxTime = 60;
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
            if (MaxTime >= 30) {
                MaxTime -= 5;
            }
        }
    }
    pStage = p;
}


static ptr<byte> DrawCell(ptr<byte> pVram, byte b)
{
    if (b == 0) {
        return Erase2(pVram);
    }
    if (b == Cell_Wall) {
        return Put2C(pVram, Char_Wall);
    }
    else if (b == Cell_Rock) {
        return Put2C(pVram, Char_Rock);
    }
    return Erase2(pVram);
}


void InitTrying()
{
    {
        StageTime = MaxTime;
        {
            byte i;
            i = pStage->monsterCount;
            do {
                StageTime += 30;
                --i;
            } while (i != 0);
        }
        {
            byte i;
            i = pStage->carCount;
            do {
                StageTime -= 10;
                --i;
            } while (i != 0);
        }
    }
    HideAllSprites();
    ClearScreen();
    PrintStatus();
    {
        ptr<byte> pSource, pDestination;
        ptr<byte> pVram;
        pSource = pStage->bytes;
        pDestination = CellMap;
        pVram = VramTop;
        repeat (MapHeight) {
            repeat (MapWidth / 4) {
                byte source;
                source = *pSource; ++pSource;
                repeat (2) {
                    byte destination;
                    destination = 0;
                    repeat (2) {
                        byte b;
                        b = source & 3;
                        pVram = DrawCell(pVram, b);
                        destination >>= 4;
                        destination |= b << 4;
                        source >>= 2;
                    }
                    *pDestination = destination; ++pDestination;
                }
            }
            pVram += VramRowSize * 2 - MapWidth * 2 * VramStep;
        }
    }
    // MapToVram();
    InitMan();
    InitCars();
    InitMonsters();
    InitItems();
    InitPoints();
    // UpdateSprites();
    DrawFence();
}


bool CanMoveTo(byte x, byte y)
{
    byte cell;
    if (x >= MapWidth || y >= MapHeight) return false;
    cell = GetCell(x, y);
    return cell != Cell_Wall && cell != Cell_Rock;
}


void EraseCell(byte x, byte y)
{
    SetCell(x, y, Cell_Space);
    Erase2XY(x << 1, (y << 1) + StageTop);
}
