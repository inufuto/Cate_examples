#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr ptr<byte> LeftTop = Vram + VramRowSize * 12 + 32 * VramStep;

void PrintRader()
{
    word vram = LeftTop;
    repeat(12) {
        repeat(8) {
            vram = Put(vram, Char_Map);
        }
        vram += VramRowSize - 8 * VramStep;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    x >>= 3;
    y >>= 3;
    word w = (y << 2) + y;
    w <<= 3;
    w += x;
    w <<= 3;
    Put(LeftTop + w, visible ? Char_Map + 1 : Char_Map);
}

void DrawFighterOnRader()
{
    byte x, y, xMod, yMod, bit;
    word w;
    x = (FighterX - 1) >> 1;
    xMod = (x & 3) << 1;
    x >>= 2;
    y = (FighterY - 1) >> 1;
    yMod = (y & 3) << 1;
    y >>= 2;
    w = (y << 2) + y;
    w <<= 3;
    w += x;
    w <<= 3;
    bit = 0xc0 >> xMod;
    PlotMarker(LeftTop + w + yMod, bit);
}
