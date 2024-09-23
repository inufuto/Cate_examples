#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr ptr<byte> LeftTop = Vram + VramRowSize * 12 + 32 * 2;

void PrintRader()
{
    word vram;
    vram= LeftTop;
    repeat(12) {
        repeat(8) {
            Put(vram, Char_Map);
            vram += 2;
        }
        vram += VramRowSize - 8 * 2;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    word w;
    x >>= 2;
    y >>= 2;
    w = (y << 2) + y;
    w <<= 6;
    Put(LeftTop + w + x, visible ? Char_Map + 1 : Char_Map);
}


void DrawFighterOnRader()
{
    byte x, y;
    word w, bytes;
    x = (FighterX - 1) << 1;
    y = (FighterY - 1);
    if (y >= 95) y = 0;
    bytes = ((word)0x000f) << (x & 7);
    x >>= 3;
    w = y;
    w = (w << 2) + w;
    w <<= 4;
    PlotMarker(LeftTop + w + x, bytes);
}
