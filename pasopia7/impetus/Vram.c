#include "Vram.h"
#include "Chars.h"

extern byte[] Backup;
extern byte[] MonoPattern, ColorPattern, AsciiPattern;


void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, AsciiPattern, 0x40, 7);
    MakePatternMono(Char_Logo, MonoPattern + (Char_Logo - Char_Logo) * CharHeight, 16, 5);
    MakePatternMono(
        Char_FighterBullet, MonoPattern + (Char_FighterBullet - Char_Logo) * CharHeight, 3, 6
    );
    MakePatternColor(Char_BarrierHead, ColorPattern, Char_End - Char_BarrierHead);
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + VramStep;
}
