#include "Vram.h"
#include "Chars.h"
#include "Star.h"
#include "Fort.h"
#include "Barrier.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearPage();
        DrawStars();
        DrawForts();
        DrawBarriers();
        SwitchPage();
    }
}


ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 - VramRowSize * 2;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 - VramRowSize * 2;
}


ptr<byte> Put4S(ptr<byte> pVram, ptr<byte> pChars)
{
    repeat (4) {
        repeat (4) {
            pVram = Put(pVram, *pChars);
            ++pChars;
        }
        pVram += VramRowSize - 4 * VramStep;
    }
    return pVram + 4 - VramRowSize * 4;
}


void Write1(sbyte x, sbyte y, byte c) 
{
    ptr<byte> p;
    if (x < 0) return;
    if (x >= WindowWidth) return;
    if (y < 0) return;
    if (y >= WindowHeight) return;
    *(pNextPage + VramOffset(x, y)) = c;
}

void Write6(sbyte x, sbyte y, byte c) 
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

    pRow = pNextPage + VramOffset(x, y);
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
        pRow += VramRowSize;
        c += Size;
        --height;
    } while (height != 0);
}