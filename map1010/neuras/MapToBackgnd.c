#include "MapToBackgnd.h"
#include "Vram.h"
#include "Stage.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToBackgnd() {
    {
        ptr<byte> pBg;
        ptr<byte> pMap;
        byte b, bit;
        word count;

        pBg = Backgnd;
        pMap = WallMap;
        b = *pMap;
        ++pMap;
        bit = 1;
        count = StageWidth * StageHeight;
        do {
            if ((b & bit) != 0) {
                *pBg = 0x0f;
            }
            else {
                *pBg = 0;
            }
            ++pBg;
            if ((bit <<= 1) == 0) {
                b = *pMap;
                ++pMap;
                bit = 1;
            }
        } while (--count != 0);
    }
    {
        byte x, y;
        ptr<byte> pBg;

        pBg = Backgnd;
        for (y = 0; y < StageHeight; ++y) {
            for (x = 0; x < StageWidth; ++x) {
                byte c, old;
                old = pBg[0];
                c = old;
                if (x > 0 && pBg[-1] != 0) {
                    c &= ~Wall_Left;
                }
                if (pBg[1] != 0) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && pBg[-StageWidth] != 0) {
                    c &= ~Wall_Top;
                }
                if (y < StageHeight-1 && pBg[StageWidth] != 0) {
                    c &= ~Wall_Bottom;
                }
                if (c == 0 && old != 0) {
                    c = 0x10;
                }
                *pBg = c;
                ++pBg;
            }
        }
    }
    {
        ptr<byte> pBg;
        word count;
        pBg = Backgnd;
        count = StageWidth * StageHeight;
        do {
            if (*pBg == 0x10) {
                *pBg = 0;
            }
            ++pBg;
            --count;
        }
        while (count != 0);
    }
    {
        ptr<byte> pFlags;
        pFlags = RowFlags;
        repeat(4) {
            *pFlags = 0xff;
            ++pFlags;
        }
    }
}