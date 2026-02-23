#include "Vram.h"
#include "Chars.h"

extern byte[] MonoPattern, BulletPattern, ColorPattern, AsciiPattern;


void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, AsciiPattern, 7, 0x40);
    SetPcgMono(Char_Logo, MonoPattern + (Char_Logo - Char_Logo) * CharHeight, 6, 16);
    SetPcgMono(Char_Ladder, MonoPattern + (Char_Ladder - Char_Logo) * CharHeight, 6, 2);
    SetPcgMono(Char_Floor, MonoPattern + (Char_Floor - Char_Logo) * CharHeight, 1, 2);
    SetPcgColor(Char_Remain, ColorPattern + 3 * CharHeight, 4);
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
