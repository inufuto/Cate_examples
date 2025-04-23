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
    MakePatternColor(Char_Floor, ColorChars, Char_End - Char_Floor);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
