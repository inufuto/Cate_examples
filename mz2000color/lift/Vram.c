#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 7);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 5);
    MakePatternColor(Char_Floor, ColorChars, Char_End - Char_Floor);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
