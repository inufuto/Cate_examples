#include "MapToBackgnd.h"
#include "VVram.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToBackgnd() {
    ptr<byte> pVVram;

    {
        ptr<byte> pMap;
        byte b, bit;

        pVVram = VVram;
        pMap = WallMap;
        b = *pMap;
        ++pMap;
        bit = 1;
        repeat (StageHeight) {
            repeat (StageWidth) {
                byte c;
                if ((b & bit) != 0) {
                    c = Char_Wall | 0x0f;
                }
                else {
                    c = Char_Wall;
                }
                *pVVram = c;
                ++pVVram;
                if ((bit <<= 1) == 0) {
                    b = *pMap;
                    ++pMap;
                    bit = 1;
                }
            }
            pVVram += VVramWidth - StageWidth;
        }
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
                *pVVram = c;
                ++pVVram;
            }
            pVVram += VVramWidth - StageWidth;
        }
    }
    {
        pVVram = VVram;
        repeat (StageHeight) {
            repeat (StageWidth) {
                if (*(pVVram) == 0x10) {
                    *pVVram = Char_Wall;
                }
                ++pVVram;
            }
            pVVram += VVramWidth - StageWidth;
        }
    }
}