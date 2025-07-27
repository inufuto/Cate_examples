#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 7);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 5);
    MakePatternMono(Char_Fence, MonoChars + (Char_Fence - Char_Logo) * CharHeight, 2, 1);
    MakePatternColor(Char_Wall, ColorChars, Char_End - Char_Wall);
}

word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + CharHeight;
}
