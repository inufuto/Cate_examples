#include "VVram.h"

extern void _deb();

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

void Put6(sbyte x, sbyte y, ptr<byte> pChars)
{
    constexpr byte size = 6;
    byte width, height;
    ptr<byte> pRow;

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
        pChars += -x;
        x = 0;
    }

    height = size;
    if (y >= VVramHeight - size) {
        height = VVramHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
        pChars += size;
    }

    pRow = VVramBack + VVramOffset(x, y);

    do {
        ptr<byte> p, px;
        byte count;
        p = pRow;
        count = width;
        px = pChars;
        do {
            *p = *px;
            ++p;
            ++px;
            --count;
        } while (count != 0);
        pRow += VVramWidth;
        pChars += size;
        --height;
    } while (height != 0);
}