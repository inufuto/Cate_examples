#include "Vram.h"

void WriteVram4(word vram, ptr<byte> pCodes)
{
    repeat (2) {
        repeat (2) {
            WriteVram(vram, *pCodes);
            ++pCodes;
            ++vram;
        }
        vram += VramWidth - 2;
    }
}


void Put4C(byte x, byte y, byte c)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            WriteVram(vram, c);
            ++c;
            ++vram;
        }
        vram += VramWidth - 2;
    }
}
