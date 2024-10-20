#include "Vram.h"
#include "Chars.h"
#include "Map.h"

extern void _deb();

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            c += 2;
        }
        c += 1 - 4;
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + (2 * VramStep - VramRowSize * 2);
}


void WPut1(byte x, byte y, byte c)
{
    x -= BaseX;
    y -= BaseY;
    if (x < WindowWidth && y < WindowHeight) {
        WriteVram(VramOffset(x, y) + NextPage, c);
    }
}


void WPut2(byte x, byte y, byte c)
{
    x -= BaseX;
    y -= BaseY;
    word vram = VramOffset(x + 1, y + 1) + NextPage - (VramRowSize + 1);
            if (y == 2) {
                _deb();
            }
    repeat (2) {
        if (y < WindowHeight) {
            repeat (2) {
                if (x < WindowWidth) {
                    vram = WriteVram(vram, c);
                }
                else {
                    vram += VramStep;
                }
                ++x;
                c += 2;
            }
            c += 1 - 4;
            vram += VramRowSize - 2 * VramStep;
            x -= 2;
        }
        else {
            vram += VramRowSize;
            ++c;
        }
        ++y;
    }
}