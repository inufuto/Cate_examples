#include "MapToBackgnd.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;
constexpr word VramTop = Vram + VramRowSize;

void MapToBackgnd() {
    word vram;
    {
        ptr<byte> pMap;
        byte b, bit;
        vram = VramTop;
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
                vram = Put(vram, c);
                if ((bit <<= 1) == 0) {
                    b = *pMap;
                    ++pMap;
                    bit = 1;
                }
            }
            vram += VramRowSize - StageWidth * VramStep;
        }
    } 
    {
        byte x, y;
        vram = VramTop;
        for (y = 0; y < StageHeight; ++y) {
            for (x = 0; x < StageWidth; ++x) {
                byte c, old;
                old = ReadVram(vram);
                c = old;
                if (x > 0 && ReadVram(vram - 1 * VramStep) != Char_Wall) {
                    c &= ~Wall_Left;
                }
                if (ReadVram(vram + 1 * VramStep) != Char_Wall) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && ReadVram(vram - VramRowSize) != Char_Wall) {
                    c &= ~Wall_Top;
                }
                if (y < StageHeight-1 && ReadVram(vram + VramRowSize) != Char_Wall) {
                    c &= ~Wall_Bottom;
                }
                if (c == Char_Wall && old != Char_Wall) {
                    c = 0x10;
                }
                vram = Put(vram, c);
            }
            vram += VramRowSize - StageWidth * VramStep;
        }
    }
    {
        vram = VramTop;
        repeat (StageHeight) {
            repeat (StageWidth) {
                if (ReadVram(vram) == 0x10) {
                    Put(vram, Char_Wall);
                }
                vram += VramStep;
            }
            vram += VramRowSize - StageWidth * VramStep;
        }
    }
}