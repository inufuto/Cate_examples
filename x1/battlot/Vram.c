#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, Ascii, 7, Char_Logo - Char_Ascii);
    SetPcgMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 5, 16);
    SetPcgMono(Char_Wall, MonoChars + (Char_Wall - Char_Logo) * CharHeight, 2, 2);
    SetPcgMono(Char_HardWall, MonoChars + (Char_HardWall - Char_Logo) * CharHeight, 7, 1);
    SetPcgMono(Char_Meter, MonoChars + (Char_Meter - Char_Logo) * CharHeight, 6, 4);
    SetPcgMono(Char_Fence, MonoChars + (Char_Fence - Char_Logo) * CharHeight, 1, 2);
    SetPcgColor(Char_MyFort, ColorChars, Char_End - Char_MyFort);
}