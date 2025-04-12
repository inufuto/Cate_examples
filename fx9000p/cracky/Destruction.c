#include "Destruction.h"
#include "Stage.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

constexpr byte MaxCount = 3;
constexpr byte MaxTime = 3;

struct Destruction {
    byte column, floor;
    byte time;
};
Destruction[MaxCount] Destructions;
static byte clock;

void InitDestructions()
{
    ptr<Destruction> pDestruction;
    for (pDestruction: Destructions) {
        pDestruction->time = 0;
    }
    clock = 0;
}

void StartDestruction(byte column, byte floor)
{
    ptr<Destruction> pDestruction;
    for (pDestruction: Destructions) {
        if (pDestruction->time == 0) {
            pDestruction->column = column;
            pDestruction->floor = floor;
            pDestruction->time = MaxTime;
            SetCell(column, floor, Cell_BrokenFloor | Cell_HardFloor);
            return;
        }
    }
}


void UpdateDestructions()
{
    ptr<Destruction> pDestruction;
    ++clock;
    if ((clock & CoordMask) != 0) return;
    for (pDestruction: Destructions) {
        if (pDestruction->time != 0) {
            byte time;
            byte x, y;
            time = pDestruction->time - 1;
            pDestruction->time = time;
            x = pDestruction->column << 1;
            y = ((pDestruction->floor << 2) + (FloorHeight - 1));
            if (time == 0) {
                SetCell(pDestruction->column, pDestruction->floor, Cell_BrokenFloor);
            }
        }
    }
}


void DrawDestructions()
{
    ptr<Destruction> pDestruction;
    ++clock;
    if ((clock & CoordMask) != 0) return;
    for (pDestruction: Destructions) {
        if (pDestruction->time != 0) {
            byte x, y;
            x = pDestruction->column << 1;
            y = ((pDestruction->floor << 2) + (FloorHeight - 1));
            {
                ptr<byte> pVVram;
                byte c;
                pVVram = VVramPtr(x, y);
                c = Char_CrackedFloor + ((MaxTime - pDestruction->time) << 1);
                repeat (2) {
                    *pVVram = c; ++pVVram;
                    ++c;
                }
            }
        }
    }
}