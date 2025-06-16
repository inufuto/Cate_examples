#include "MapToBackgnd.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

void MapToBackgnd() {
    word address;

    address = VRAM_PatternName + Vram_Width * 2;
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
            PrintC(address, c);
            ++address;
            if ((bit <<= 1) == 0) {
                b = *pMap;
                ++pMap;
                bit = 1;
            }
        } while (--count != 0);
    } 
    {
        byte x, y;

        address = VRAM_PatternName + Vram_Width * 2;
        for (y = 0; y < StageHeight; ++y) {
            for (x = 0; x < StageWidth; ++x) {
                byte c, old;
                old = ReadVram(address);
                c = old;
                if (x > 0 && ReadVram(address - 1) != Char_Wall) {
                    c &= ~Wall_Left;
                }
                if (ReadVram(address + 1) != Char_Wall) {
                    c &= ~Wall_Right;
                }
                if (y > 0 && ReadVram(address - Vram_Width) != Char_Wall) {
                    c &= ~Wall_Top;
                }
                if (y < StageHeight-1 && ReadVram(address + Vram_Width) != Char_Wall) {
                    c &= ~Wall_Bottom;
                }
                if (c == Char_Wall && old != Char_Wall) {
                    c = 0x10;
                }
                PrintC(address, c);
                ++address;
            }
        }
    }
    {
        word count;
        address = VRAM_PatternName + Vram_Width * 2;
        count = StageWidth * StageHeight;
        do {
            if (ReadVram(address) == 0x10) {
                PrintC(address, Char_Wall);
            }
            ++address;
            --count;
        }
        while (count != 0);
    }
}