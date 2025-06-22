#include "Rader.h"
#include "Vram.h"
#include "VVram.h"
#include "Fighter.h"
#include "Chars.h"

constexpr byte RaderTop = 12;

void PrintRader()
{
    word vram;
    vram = Vram + VramRowSize * RaderTop + VVramWidth * VramStep;
    repeat (12) {
        repeat (8) {
            vram = Put(vram, Char_Map);
        }
        vram += VramRowSize - 8 * VramStep;
    }
}
