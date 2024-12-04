#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte RaderTop = 12;
constexpr byte RaderLeft = VVramWidth;
constexpr ptr<byte> LeftTop = Vram + VramRowSize * RaderTop + RaderLeft * VramStep;

void PrintRader()
{
    word vram;
    vram = LeftTop;
    repeat(12) {
        repeat(8) {
            Put(vram, Char_Map);
            vram += VramStep;
        }
        vram += VramRowSize - 8 * VramStep;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    x >>= 4;
    y >>= 4;
    Put(VramAddress(RaderLeft + x, RaderTop + y), visible ? Char_Map + 1 : Char_Map);
}
