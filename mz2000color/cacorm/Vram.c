#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii, FenceChars;
extern byte[] LineChars;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 7);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 5);
    MakePatternMono(Char_Block, MonoChars + (Char_Block - Char_Logo) * CharHeight, 4, 1);
    MakePatternMono(Char_Item, MonoChars + (Char_Item - Char_Logo) * CharHeight, 4, 6);
    MakePatternMono(Char_Line_Normal, LineChars, 8, 7);
    MakePatternMono(Char_Line_Red, LineChars, 8, 2);
    MakePatternMono(Char_Fence, FenceChars, 2, 1);
    MakePatternColor(Char_Man, ColorChars, Char_Fence - Char_Man);
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
