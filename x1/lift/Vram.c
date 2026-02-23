#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, Ascii, 7, Char_Logo - Char_Ascii);
    SetPcgMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 5, 16);
    SetPcgColor(Char_Floor, ColorChars, Char_End - Char_Floor);
}
