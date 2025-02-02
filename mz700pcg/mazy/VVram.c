#include "VVram.h"
#include "Vram.h"
#include "Chars.h"
#include "Map.h"

byte[VVramWidth * VVramHeight] VVram;


void VPut1(sbyte x, sbyte y, byte c)
{
    x -= BaseX;
    y -= BaseY;
    if (x < 0) return;
    if (x >= VVramWidth) return;
    if (y < 0) return;
    if (y >= VVramHeight) return;
    *VVramPtr(x, y) = c;
}

void VPut2(sbyte x, sbyte y, byte cc)
{
    constexpr byte size = 2;
    byte width, height;
    ptr<byte> pRow;

    x -= BaseX;
    y -= BaseY;

    if (x <= -size) return;
    if (x >= VVramWidth) return;
    if (y <= -size) return;
    if (y >= VVramHeight) return;

    width = size;
    if (x >= VVramWidth - size) {
        width = VVramWidth - x;
    }
    else if (x < 0) {
        width += x;
        cc -= x;
        x = 0;
    }

    height = size;
    if (y >= VVramHeight - size) {
        height = VVramHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
        cc += size;
    }

    pRow = VVramPtr(x, y);

    do {
        ptr<byte> p;
        byte count, xc;
        p = pRow;
        count = width;
        xc = cc;
        do {
            *p = xc;
            ++p;
            ++xc;
            --count;
        } while (count != 0);
        pRow += VVramWidth;
        cc += size;
        --height;
    } while (height != 0);
}