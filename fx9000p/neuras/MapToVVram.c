#include "MapToVVram.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToVVram() 
{
    {
        ptr<byte> pBack;
        ptr<byte> pMap;

        pBack = VVramBack;
        pMap = WallMap;
        repeat (VVramHeight) {
            byte b, bit;

            b = *pMap; ++pMap;
            bit = 2;
            repeat (VVramWidth - 1) {
                if ((b & bit) != 0) {
                    *pBack = 0x0f;
                }
                else {
                    *pBack = 0;
                }
                ++pBack;
                if ((bit <<= 1) == 0) {
                    b = *pMap; ++pMap;
                    bit = 1;
                }
            }
            ++pBack;
        }
    }
    {
        byte x, y;
        ptr<byte> pBack;

        pBack = VVramBack;
        for (y = 0; y < VVramHeight; ++y) {
            for (x = 0; x < VVramWidth - 1; ++x) {
                byte c, old;
                old = pBack[0];
                c = old;
                if (x == 0 || pBack[-1] != 0) {
                    c &= ~Wall_Left;
                }
                if (x == VVramWidth - 2 || pBack[1] != 0) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && pBack[-VVramWidth] != 0) {
                    c &= ~Wall_Top;
                }
                if (y < VVramHeight - 1 && pBack[VVramWidth] != 0) {
                    c &= ~Wall_Bottom;
                }
                if (c == 0 && old != 0) {
                    c = 0x10;
                }
                *pBack = c; ++pBack;
            }
            *pBack = 0x0f; ++pBack;
        }
    }
    {
        ptr<byte> pBack;
        word count;
        byte c;

        pBack = VVramBack;
        count = VVramWidth * VVramHeight;
                            _deb();
        do {
            c = *pBack;
            if (c == 0 || c == 0x10) {
                c = Char_Wall;
            }
            else  {
                c += Char_Wall;
            }
            *pBack = c;
            ++pBack;
            --count;
        }
        while (count != 0);
    }
}