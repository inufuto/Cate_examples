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

    {
        ptr<byte> pMap;
        byte b, bit;

        pVram = VramTop;
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
                pVram[0] = c;
                pVram += VramStep;
                if ((bit <<= 1) == 0) {
                    b = *pMap;
                    ++pMap;
                    bit = 1;
                }
            }
            pVram += VramRowSize - StageWidth * VramStep;
        }
    } 
    {
        byte x, y;

        pVram = VramTop;
        for (y = 0; y < StageHeight; ++y) {
            for (x = 0; x < StageWidth; ++x) {
                byte c = pVram[0];
                byte old = c;
                if (x > 0 && pVram[-VramStep] != Char_Wall) {
                    c &= ~Wall_Left;
                }
                if (pVram[VramStep] != Char_Wall) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && pVram[-VramRowSize] != Char_Wall) {
                    c &= ~Wall_Top;
                }
                if (y < StageHeight - 1 && pVram[VramRowSize] != Char_Wall) {
                    c &= ~Wall_Bottom;
                }
                if (c == Char_Wall && old != Char_Wall) {
                    c = 0x10;
                }
                pVram[0] = c;
                pVram += VramStep;
            }
            pVram += VramRowSize - StageWidth * VramStep;
        }
    }
    {
        pVram = VramTop;
        repeat (StageHeight) {
            repeat (StageWidth) {
                byte c = pVram[0];
                if (c == 0x10) {
                    c = Char_Wall;
                }
                pVram = Put(pVram, c);
            }
            pVram += VramRowSize - StageWidth * VramStep;
        }
    }
}