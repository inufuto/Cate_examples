#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 7);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 5);
    MakePatternMono(Char_Wall, MonoChars + (Char_Wall - Char_Logo) * CharHeight, 2, 2);
    MakePatternMono(Char_HardWall, MonoChars + (Char_HardWall - Char_Logo) * CharHeight, 1, 7);
    MakePatternMono(Char_Meter, MonoChars + (Char_Meter - Char_Logo) * CharHeight, 2, 6);
    MakePatternMono(Char_Bullet, MonoChars + (Char_Bullet - Char_Logo) * CharHeight, 2, 6);
    MakePatternMono(Char_Fence, MonoChars + (Char_Fence - Char_Logo) * CharHeight, 2, 1);
    MakePatternColor(Char_MyFort, ColorChars, Char_End - Char_MyFort);
}

word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + CharHeight;
}
