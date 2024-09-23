#include "VVram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;


void Put1(sbyte x, sbyte y, byte c)
{
    if (x < 0) return;
    if (x >= VVramWidth) return;
    if (y < 0) return;
    if (y >= VVramHeight) return;
    VVramBack[VVramOffset(x, y)] = c;
}


void Put6(sbyte x, sbyte y, byte c)
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

    pRow = VVramBack + VVramOffset(x, y);

    do {
        ptr<byte> p;
        byte count, xc;
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