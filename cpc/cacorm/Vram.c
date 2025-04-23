#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[] Backup;

extern byte[] MonoChars, ColorChars, Ascii, FenceChars, LineChars;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 3);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 2);
    MakePatternMono(Char_Man, MonoChars + (Char_Man - Char_Logo) * CharHeight, 32, 3);
    MakePatternMono(Char_Monster, MonoChars + (Char_Monster - Char_Logo) * CharHeight, 32, 1);
    MakePatternMono(Char_Point, MonoChars + (Char_Point - Char_Logo) * CharHeight, 16, 3);
    MakePatternMono(Char_Increaser, MonoChars + (Char_Increaser - Char_Logo) * CharHeight, 4, 2);
    MakePatternMono(Char_Block, MonoChars + (Char_Block - Char_Logo) * CharHeight, 4, 2);
    MakePatternColor(Char_Item, ColorChars, 4);
    MakePatternMono(Char_Line_Normal, LineChars, 8, 3);
    MakePatternMono(Char_Line_Red, LineChars, 8, 1);
    MakePatternMono(Char_Fence, FenceChars, 2, 3);
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
