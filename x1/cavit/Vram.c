#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, Ascii, 7, Char_Logo - Char_Ascii);
    SetPcgMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 6, 16);
    SetPcgMono(Char_Soil, MonoChars + (Char_Soil - Char_Logo) * CharHeight, 6, 2);
    SetPcgMono(Char_Bedrock, MonoChars + (Char_Bedrock - Char_Logo) * CharHeight, 7, 1);
    SetPcgMono(Char_Wall, MonoChars + (Char_Wall - Char_Logo) * CharHeight, 6, 9);
    SetPcgColor(Char_Remain, ColorChars, Char_End - Char_Remain);
}