#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[] Backup;

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 3);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 2);
    MakePatternMono(Char_Soil, MonoChars + (Char_Soil - Char_Logo) * CharHeight, 2, 2);
    MakePatternMono(Char_Bedrock, MonoChars + (Char_Bedrock - Char_Logo) * CharHeight, 1, 3);
    MakePatternMono(Char_Wall, MonoChars + (Char_Wall - Char_Logo) * CharHeight, 9, 2);
    MakePatternColor(Char_Man, ColorChars, Char_End - Char_Man);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
