#include "MapToBackgnd.h"
#include "Vram.h"
#include "Stage.h"
#include "Chars.h"

extern void _deb();

constexpr byte Wall_Left = 0x01;
constexpr byte Wall_Right = 0x02;
constexpr byte Wall_Top = 0x04;
constexpr byte Wall_Bottom = 0x08;

constexpr byte RangeX = StageWidth - 2;
constexpr byte RangeY = StageHeight - 2;

void MapToBackgnd()
{
    {
        ptr<byte> pMap;
        ptr<byte> pVram;
        byte y;
        pMap = WallMap;
        pVram = Vram + VramRowSize * 1 - 1 * VramStep;
        y = -1;
        repeat (StageHeight) {
            byte x;
            x = -1;
            repeat (MapWidth) {
                byte b, bit;
                b = *pMap; ++pMap;
                bit = 1;
                repeat (8) {
                    byte c;
                    if ((b & bit) != 0) {
                        c = Char_Wall | 0x0f;
                    }
                    else {
                        c = Char_Wall;
                    }
                    bit <<= 1;
                    if (x < RangeX && y < RangeY) {
                        Put(pVram, c);
                    }
                    pVram += VramStep;
                    ++x;
                }
            }
            pVram += VramRowSize - MapWidth * 8 * VramStep;
            ++y;
        }
    } 
    {
        ptr<byte> pVram;
        byte x, y;
        pVram = Vram + VramRowSize * 2;
        for (y = 0; y < RangeY; ++y) {
            for (x = 0; x < RangeX; ++x) {
                byte c, old;
                old = ReadVram(pVram);
                c = old;
                if (x == 0 || ReadVram(pVram - VramStep) != Char_Wall) {
                    c &= ~Wall_Left;
                }
                if (x == RangeX - 1 || ReadVram(pVram + VramStep) != Char_Wall) {
                    c &= ~Wall_Right;
                }
                if (y == 0 || ReadVram(pVram - VramRowSize) != Char_Wall) {
                    c &= ~Wall_Top;
                }
                if (y == RangeY - 1 || ReadVram(pVram + VramRowSize) != Char_Wall) {
                    c &= ~Wall_Bottom;
                }
                if (c == Char_Wall && old != Char_Wall) {
                    c = Char_Wall + 0x10;
                }
                pVram = Put(pVram, c);
            }
            pVram += VramRowSize - RangeX * VramStep;
        }
    }
    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 2;
        repeat (RangeY) {
            repeat (RangeX) {
                if (ReadVram(pVram) == 0x10) {
                    Put(pVram, Char_Wall);
                }
                pVram += VramStep;
            }
            pVram += VramRowSize - RangeX * VramStep;
       }
        repeat (RangeX) {
            pVram = Put(pVram, Char_Wall + 15);
        }
    }
}