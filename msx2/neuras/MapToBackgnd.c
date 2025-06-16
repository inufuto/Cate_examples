#include "MapToBackgnd.h"
#include "Vram.h"
#include "VVram.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToBackgnd() {
    ptr<byte> pVVram;

    pVVram = VVram;
    {
        ptr<byte> pMap;
        byte b, bit;
        word count;

        pMap = WallMap;
        b = *pMap;
        ++pMap;
        bit = 1;
        count = StageWidth * StageHeight;
        do {
            byte c;
            if ((b & bit) != 0) {
                c = Char_Wall | 0x0f;
            }
            else {
                c = Char_Wall;
            }
            *pVVram = c; ++pVVram;
            if ((bit <<= 1) == 0) {
                b = *pMap;
                ++pMap;
                bit = 1;
            }
        } while (--count != 0);
    } 
    {
        byte x, y;

        pVVram = VVram;
        for (y = 0; y < StageHeight; ++y) {
            for (x = 0; x < StageWidth; ++x) {
                byte c, old;
                old = pVVram[0];
                c = old;
                if (x > 0 && pVVram[-1] != Char_Wall) {
                    c &= ~Wall_Left;
                }
                if (pVVram[1] != Char_Wall) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && pVVram[-VVramWidth] != Char_Wall) {
                    c &= ~Wall_Top;
                }
                if (y < StageHeight-1 && pVVram[VVramWidth] != Char_Wall) {
                    c &= ~Wall_Bottom;
                }
                if (c == Char_Wall && old != Char_Wall) {
                    c = 0x10;
                }
                *pVVram = c; ++pVVram;
            }
        }
    }
    {
        word count;
        pVVram = VVram;
        count = VVramWidth * VVramHeight;
        do {
            if (*pVVram == 0x10) {
                *pVVram = Char_Wall;
            }
            ++pVVram;
            --count;
        }
        while (count != 0);
    }
}