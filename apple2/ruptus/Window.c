#include "Window.h"
#include "Chars.h"
#include "CopyMemory.h"

byte[WindowWidth * WindowHeight] WindowBack;
byte[WindowWidth * WindowHeight] WindowFront;
bool WindowChanged;
byte[3] RowFlags;


void ClearWindow()
{
    FillMemory(WindowBack, WindowWidth * WindowHeight, Char_Space);
}


void WindowBackToFront()
{
    CopyMemory(WindowFront, WindowBack, WindowWidth * WindowHeight);
    RowFlags[0] = 0;
    RowFlags[1] = 0;
    RowFlags[2] = 0;
}


word WindowOffset(byte x, byte y)
{
    word w;
    w = ((y + y + y) << 1); // *6
    w <<= 2;    // *24
    return w + x;
}


void Put1(sbyte x, sbyte y, byte c)
{
    if (x < 0) return;
    if (x >= WindowWidth) return;
    if (y < 0) return;
    if (y >= WindowHeight) return;
    WindowBack[WindowOffset(x, y)] = c;
}

void Put6(sbyte x, sbyte y, byte c)
{
    constexpr byte size = 6;
    byte width, height;
    ptr<byte> pRow;

    if (x <= -size) return;
    if (x >= WindowWidth) return;
    if (y <= -size) return;
    if (y >= WindowHeight) return;

    width = size;
    if (x >= WindowWidth - size) {
        width = WindowWidth - x;
    }
    else if (x < 0) {
        width += x;
        c -= x;
        x = 0;
    }

    height = size;
    if (y >= WindowHeight - size) {
        height = WindowHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
        c += size;
    }

    pRow = WindowBack + WindowOffset(x, y);

    do {
        ptr<byte> p;
        byte xc, count;
        p = pRow;
        count = width;
        xc = c;
        do {
            *p = xc;
            ++p;
            ++xc;
            --count;
        } while (count != 0);
        pRow += WindowWidth;
        c += size;
        --height;
    } while (height != 0);
}