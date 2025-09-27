#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr word LeftTop = Vram + VramRowSize * 12 + WindowWidth * VramStep;

void PrintRader()
{
    word vram;
    vram= LeftTop;
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
    Put(Vram + VramOffset(x + WindowWidth, y + VramHeight / 2), visible ? Char_Map + 1 : Char_Map);
}
