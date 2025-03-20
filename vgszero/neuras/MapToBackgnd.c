#include "MapToBackgnd.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToBackgnd() {
    ptr<byte> pVram;

    pVram = VramBack + VramRowSize * 2;
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
            Put(pVram, c);
            pVram += VramStep;
            if ((bit <<= 1) == 0) {
                b = *pMap;
                ++pMap;
                bit = 1;
            }
        } while (--count != 0);
    } 
    {
        byte x, y;

        pVram = VramBack + VramRowSize * 2;
        for (y = 0; y < StageHeight; ++y) {
            for (x = 0; x < StageWidth; ++x) {
                byte old = pVram[0];
                byte c = old;
                if (x > 0 && pVram[-VramStep] != Char_Wall) {
                    c &= ~Wall_Left;
                }
                if (pVram[VramStep] != Char_Wall) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && pVram[-VramRowSize] != Char_Wall) {
                    c &= ~Wall_Top;
                }
                if (y < StageHeight-1 && pVram[VramRowSize] != Char_Wall) {
                    c &= ~Wall_Bottom;
                }
                if (c == Char_Wall && old != Char_Wall) {
                    c = Char_Wall;
                }
                Put(pVram, c);
                pVram += VramStep;
            }
        }
    }
    {
        word count;
        pVram = VramBack + VramRowSize * 2;
        count = StageWidth * StageHeight;
        do {
            if (pVram[0] == 0x10) {
                Put(pVram, Char_Wall);
            }
            pVram += VramStep;
            --count;
        }
        while (count != 0);
    }
}