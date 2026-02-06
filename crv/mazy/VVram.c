#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Map.h"

void VPut1(sbyte x, sbyte y, byte c)
{
    x -= BaseX;
    y -= BaseY;
    if (x < 0) return;
    if (x >= VVramWidth) return;
    if (y < 0) return;
    if (y >= VVramHeight) return;
    Put(VVramAddress(x, y), c);
}

void VPut2(sbyte x, sbyte y, byte cc)
{
    constexpr byte size = 2;
    byte width, height;
    word wRow;

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

    wRow = VVramAddress(x, y);

    do {
        word vv;
        byte count, xc;
        vv = wRow;
        count = width;
        xc = cc;
        do {
            vv = Put(vv, xc);
            ++xc;
            --count;
        } while (count != 0);
        wRow += VVramWidth;
        cc += size;
        --height;
    } while (height != 0);
}