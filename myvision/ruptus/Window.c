#include "Window.h"

byte[WindowWidth * WindowHeight] Window;
bool WindowChanged;

void ClearWindow() 
{
    ptr<byte> pWindow;
    word count;
    pWindow = Window;
    count = WindowWidth * WindowHeight;
    do {
        *pWindow = ' ';
        ++pWindow;
        --count;
    } while (count != 0);
}

ptr<byte> WindowPointer(byte x, byte y) 
{
    word w;
    w = (y << 1) + y;
    w <<= 3;
    return Window + w + x;
}

void Put1(sbyte x, sbyte y, byte c) 
{
    ptr<byte> p;
    if (x < 0) return;
    if (x >= WindowWidth) return;
    if (y < 0) return;
    if (y >= WindowHeight) return;
    *WindowPointer(x, y) = c;
}

void Put6(sbyte x, sbyte y, byte c) 
{
    constexpr byte Size = 6;
    byte width, height;
    ptr<byte> pRow;

    if (x <= -Size) return;
    if (x >= WindowWidth) return;
    if (y <= -Size) return;
    if (y >= WindowHeight) return;

    width = Size;
    if (x >= WindowWidth - Size) {
        width = WindowWidth - x;
    }
    else if (x < 0) {
        width += x;
        c -= x;
        x = 0;
    }

    height = Size;
    if (y >= WindowHeight - Size) {
        height = WindowHeight - y;
    }
    else while (y < 0) {
        --height;
        ++y;
        c += Size;
    }

    pRow = WindowPointer(x, y);
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
        c += Size;
        --height;
    } while (height != 0);
}