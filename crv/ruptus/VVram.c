#include "VVram.h"
#include "Vram.h"

bool VVramChanged;

void VPutXY(sbyte x, sbyte y, byte c) 
{
    ptr<byte> p;
    if (x < 0) return;
    if (x >= VVramWidth) return;
    if (y < 0) return;
    if (y >= VVramHeight) return;
    Put(VVramAddress(x, y), c);
}

void VPut6CXY(sbyte x, sbyte y, byte c) 
{
    constexpr byte Size = 6;
    byte width, height;
    word pRow;

    if (x <= -Size) return;
    if (x >= VVramWidth) return;
    if (y <= -Size) return;
    if (y >= VVramHeight) return;

    width = Size;
    if (x >= VVramWidth - Size) {
        width = VVramWidth - x;
    }
    else if (x < 0) {
        width += x;
        c -= x;
        x = 0;
    }

    height = Size;
    if (y >= VVramHeight - Size) {
        height = VVramHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
        c += Size;
    }

    pRow = VVramAddress(x, y);
    do {
        word p;
        byte xc, count;
        p = pRow;
        count = width;
        xc = c;
        do {
            p = Put(p, xc);
            ++xc;
            --count;
        } while (count != 0);
        pRow += VVramWidth;
        c += Size;
        --height;
    } while (height != 0);
}