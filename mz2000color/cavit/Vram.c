#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 7);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 6);
    MakePatternMono(Char_Soil, MonoChars + (Char_Soil - Char_Logo) * CharHeight, 2, 6);
    MakePatternMono(Char_Bedrock, MonoChars + (Char_Bedrock - Char_Logo) * CharHeight, 1, 7);
    MakePatternMono(Char_Wall, MonoChars + (Char_Wall - Char_Logo) * CharHeight, 9, 6);
    MakePatternColor(Char_Man, ColorChars, Char_End - Char_Man);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
