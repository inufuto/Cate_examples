#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr word LeftTop = VramLeftTop + VramWidth * 12 + 24;
constexpr word GLeftTop = GVramLeftTop + VramWidth * 12 + 24;

void PrintRader()
{
    word vram;
    vram = LeftTop;
    repeat(12) {
        repeat(8) {
            VPut1(vram, Char_Map);
            ++vram;
        }
        vram += VramWidth - 8;
    }
}


void DrawFortRader(byte x, byte y, bool visible)
{
    word w;
    x >>= 4;
    y >>= 4;
    w = (y << 2) + y;
    w <<= 3;
    VPut1(LeftTop + w + x, visible ? Char_Map + 1 : Char_Map);
}


void DrawFighterOnRader()
{
    byte x, y;
    word w1,w2, bytes;
    x = (FighterX - 2) >> 1;
    y = (FighterY - 2) >> 1;
    bytes = ((word)0xc000) >> (x & 7);
    x >>= 3;
    w1 = (y & 7);
    w1 <<= 11;
    y >>= 3;
    w2 = (y << 2) + y;
    w2 <<= 3;
    PlotMarker(GLeftTop + w1 + w2 + x, bytes);
}
