#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;

void InitVram()
{
    ClearScreen();
    MakePatternMono(Char_Ascii, Ascii, 0x40, 7);
    MakePatternMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16 + 2, 6);
    MakePatternMono(Char_Floor, MonoChars + (Char_Floor - Char_Logo) * CharHeight, 2, 1);
    MakePatternColor(Char_Man, ColorChars, Char_End - Char_Man);
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
