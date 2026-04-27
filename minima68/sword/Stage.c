#include "Stage.h"
#include "Stages.h"
#include "Main.h"
#include "Vram.h"
#include "Chars.h"
#include "Man.h"
#include "Monster.h"
#include "Ball.h"
#include "Status.h"
#include "Point.h"
#include "Math.h"
#include "OneUp.h"

constexpr byte MaxTimerValue = 50;
constexpr byte MinTimerValue = 8;

ptr<Stage> pStage;
byte[MapSize] StageMap;
byte BoxCount;
byte TimerValue;

byte ToColumn(byte b)
{
    return b >> 4;
}

byte ToRow(byte b)
{
    return b & 0x0f;
}


void InitStage()
{
    RndIndex = 0;
    TimerValue = MaxTimerValue;
    ptr<Stage> p = Stages;
    byte count = CurrentStage;
    byte i = 0;
    while (count != 0) {
        ++p;
        ++i;
        if (i >= StageCount) {
            p = Stages;
            i = 0;
        }
        --TimerValue;
        if (TimerValue < MinTimerValue) {
            TimerValue = MinTimerValue;
        }
        --count;
    }
    pStage = p;

    ClearScreen();
    PrintStatus();
    {
        BoxCount = 0;
        ptr<byte> pBytes = pStage->bytes;
        byte row = 0;
        while (row < RowCount) {
            byte column = 0;
            repeat (ColumnCount / ColumnsPerByte) {
                byte b = *pBytes; ++pBytes;
                repeat (ColumnsPerByte) {
                    byte cell = b & 0x03;
                    if (cell == Cell_Box) {
                        ++BoxCount;
                    }
                    SetCell(column, row, cell);
                    b >>= 2;
                    ++column;
                }
            }
            ++row;
        }
    }
    InitMan();
    InitMonsters();
    InitBalls();
    InitPoints();
    InitOneUp();
}

void SetCell(byte column, byte row, byte cell)
{
    SetCellBits(column, row, cell);
    ptr<byte> pVram = VramPtr(column << GridShift, (row << GridShift) + StatusHeight);
    if (cell == Cell_Space) {
        Erase2(pVram);
    }
    else {
        Put2C(pVram, Char_Wall + ((cell - 1) << 2));
    }
}
