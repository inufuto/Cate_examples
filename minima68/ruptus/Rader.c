#include "Rader.h"
#include "Vram.h"
#include "Vram.h"
#include "Fighter.h"
#include "Chars.h"


constexpr ptr<byte> LeftTop = Vram + VramRowSize * RaderTop + WindowWidth * VramStep;

void PrintRader()
{
    ptr<byte> pVram = LeftTop;
    repeat(12) {
        repeat(8) {
            pVram = Put(pVram, Char_Map);
        }
        pVram += VramRowSize - 8 * VramStep;
    }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    x >>= 4;
    y >>= 4;
    Put(Vram + VramOffset(x + WindowWidth, y + RaderTop), visible ? Char_Map + 1 : Char_Map);
}
