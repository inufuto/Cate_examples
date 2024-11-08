#include "VVram.h"
#include "Chars.h"

bool VVramChanged;

void VPutXY(sbyte x, sbyte y, byte c) 
{
    ptr<byte> p;
    if (x < 0) return;
    if (x >= VVramWidth) return;
    if (y < 0) return;
    if (y >= VVramHeight) return;
    *VVramPtr(x, y) = c;
}

void VPut6XY(sbyte x, sbyte y, word c) 
{
    constexpr byte Size = 6;
    byte width, height;
    ptr<byte> pRow;

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
        c -= (sword)x;
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

    pRow = VVramPtr(x, y);
    do {
        ptr<byte> p;
        byte count;
        word xc;
        p = pRow;
        count = width;
        xc = c;
        do {
            *p = xc;
            ++p;
            ++xc;
            --count;
        } while (count != 0);
        pRow += VVramWidth;
        c += Size;
        --height;
    } while (height != 0);
}