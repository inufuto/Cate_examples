#include "Destruction.h"
#include "Stage.h"
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
const byte[] CrackChars = {	0x07, 0x0e, 0x03, 0x0c, 0x01, 0x0c, 0x01, 0x00, };

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
    static const byte[] Chars = {	0x07, 0x0e, 0x03, 0x0c, 0x01, 0x0c, 0x01, 0x00, };
    ++clock;
    if ((clock & CoordMask) != 0) return;
    ptr<Destruction> pDestruction;
    for (pDestruction: Destructions) {
        if (pDestruction->time != 0) {
            byte time = pDestruction->time - 1;
            pDestruction->time = time;
            byte x = pDestruction->column << 1;
            byte y = ((pDestruction->floor << 2) + (FloorHeight - 1));
            {
                ptr<byte> pVVram = VVramBack + VVramOffset(x, y);
                ptr<byte> pChars = CrackChars + ((MaxTime - time) << 1);
                repeat (2) {
                    *pVVram = *pChars; ++pVVram;
                    ++pChars;
                }
                VVramChanged = true;
            }
            if (time == 0) {
                SetCell(pDestruction->column, pDestruction->floor, Cell_BrokenFloor);
            }
        }
    }
}
