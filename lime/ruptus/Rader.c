#include "Rader.h"
#include "Vram.h"
#include "VVram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr byte RaderTop = 12;
constexpr ptr<byte> LeftTop = Vram + VramRowSize * RaderTop + VVramWidth * VramStep;

void PrintRader()
{
    word vram;
    vram= LeftTop;
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
    x += VVramWidth;
    y >>= 3;
    y += RaderTop;
    Put(VramAddress(x, y), visible ? Char_Map + 1 : Char_Map);
}
