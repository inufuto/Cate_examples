#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr ptr<byte> LeftTop = Vram + VramRowSize * 12 + 32 * VramStep;
constexpr byte Char_Map = Char_Logo + 15;

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
    x >>= 2;
    y >>= 3;
    Put(RaderAddress(x, y), visible ? Char_FortOnMap : Char_Map);
}

void DrawFighterOnRader()
{
    byte x = (FighterX - 1) >> 1;
    byte y = (FighterY - 1) >> 1;
    ToggleDot(x, y);
}
