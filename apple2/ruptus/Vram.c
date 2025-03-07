#include "Vram.h"
#include "Window.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] Backup;

void ClearScreen()
{
    FillMemory(Vram, 0x2000, 0);
    FillMemory(Backup, WindowWidth * WindowHeight, 0);
}


void VPut2(byte x, byte y, byte c)
{
    repeat (2) {
        VLocate(x, y);
        repeat (2) {
            VPut1(c);
            ++c;
        }
        ++y;
    }
}


void VErase2(byte x, byte y)
{
    repeat (2) {
        VLocate(x, y);
        repeat (2) {
            VPut1(Char_Space);
        }
        ++y;
    }
}


void VPut4(byte x, byte y, ptr<byte> pBytes)
{
    repeat (4) {
        VLocate(x, y);
        repeat (4) {
            VPut1(*pBytes);
            ++pBytes;
        }
        ++y;
    }
}
