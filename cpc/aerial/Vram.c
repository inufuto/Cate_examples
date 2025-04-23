#include "Vram.h"
#include "Chars.h"

extern byte[] Backup;
extern byte[] MonoPattern, ColorPattern, AsciiPattern;


void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, AsciiPattern, 0x40, 3);
    MakePatternMono(Char_Logo, MonoPattern + (Char_Logo - Char_Logo) * CharHeight, 16, 2);
    MakePatternColor(Char_Ground, ColorPattern, Char_End - Char_Ground);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
