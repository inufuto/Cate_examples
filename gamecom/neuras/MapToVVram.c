#include "MapToVVram.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToVVram() 
{
    {
        ptr<byte> pVVram;
        ptr<byte> pMap;

        pVVram = VVram;
        pMap = WallMap + MapWidth;
        repeat (VVramHeight) {
            byte b, bit;

            b = *pMap; ++pMap;
            bit = 2;
            repeat (VVramWidth - 1) {
                if ((b & bit) != 0) {
                    *pVVram = 0x0f;
                }
                else {
                    *pVVram = 0;
                }
                ++pVVram;
                if ((bit <<= 1) == 0) {
                    b = *pMap; ++pMap;
                    bit = 1;
                }
            }
            *pVVram = 0;
            ++pVVram;
        }
    }
    {
        byte x, y;
        ptr<byte> pVVram;

        pVVram = VVram;
        for (y = 0; y < VVramHeight; ++y) {
            for (x = 0; x < VVramWidth - 1; ++x) {
                byte c, old;
                old = pVVram[0];
                c = old;
                if (x == 0 || pVVram[-1] != 0) {
                    c &= ~Wall_Left;
                }
                if (x == VVramWidth - 2 || pVVram[1] != 0) {
                    c &= ~Wall_Right;
                }
                if (y == 0 || pVVram[-VVramWidth] != 0) {
                    c &= ~Wall_Top;
                }
                if (y == VVramHeight - 2 || pVVram[VVramWidth] != 0) {
                    c &= ~Wall_Bottom;
                }
                if (c == 0 && old != 0) {
                    c = 0x10;
                }
                *pVVram = c; ++pVVram;
            }
            *pVVram = 0x0f; ++pVVram;
        }
    }
    {
        ptr<byte> pVVram = VVram;
        repeat (VVramHeight - 1) {
            repeat (VVramWidth - 1) {
                byte c = *pVVram;
                if (c == 0 || c == 0x10) {
                    c = Char_Wall;
                }
                else  {
                    c += Char_Wall;
                }
                *pVVram = c; ++pVVram;
            }
            *pVVram = Char_Wall; ++pVVram;
        }
        repeat (VVramWidth - 1) {
            *pVVram = Char_Wall + 15;++pVVram;
        }
        *pVVram = Char_Wall;
    }
}