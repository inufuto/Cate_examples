#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr ptr<byte> LeftTop = VramLeftTop + VramRowSize * 12 + 24 * 2;

void PrintRader()
{
    word vram;
    vram= LeftTop;
    repeat(12) {
        repeat(8) {
            VPut1(vram, Char_Map);
            vram += 2;
        }
        vram += VramRowSize - 8 * 2;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    word w;
    x >>= 2;
    y >>= 3;
    w = (y << 2) + y;
    w <<= 4;
    VPut1(LeftTop + w + x, visible ? Char_Map + 1 : Char_Map);
}


void _deb(){}
void DrawFighterOnRader()
{
    byte x, y, b;
    word w, yw;
    x = (FighterX - 1);
    b = 0x0c >> (x & 2);
    x >>= 2;
    y = (FighterY - 1) & 0xfe;
    if (y >= 95) y = 0;
    yw = (word)(y & 7) << 11;
    y >>= 3;
    w = (y << 2) + y;
    w <<= 4;
    PlotMarker(LeftTop + w + yw + x, b);
    // PrintC(LeftTop + w + x, '@');
}
