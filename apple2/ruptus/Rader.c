#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr byte Left = 24;
constexpr byte Top = 12;

void PrintRader()
{
    byte y;
    y = Top;
    repeat(12) {
        VLocate(Left, y);
        repeat(8) {
            VPut1(Char_Map);
        }
        ++y;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    x >>= 3;
    y >>= 3;
    VLocate(Left + x, Top + y);
    VPut1(visible ? Char_Map + 1 : Char_Map);
}


void DrawFighterOnRader()
{
    byte x, y;
    byte xMod, yMod;
    x = FighterX - 1;
    xMod = x & 6;
    x >>= 3;
    y = FighterY - 1;
    yMod = y & 6;
    y >>= 3;
    PlotMarker(Left + x, Top + y, xMod, yMod);
}
