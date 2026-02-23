#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii, FenceChars;
extern byte[] LineChars;

void InitVram()
{
    ClearScreen();
    SetPcgMono(Char_Ascii, Ascii, 7, 0x40);
    SetPcgMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 5, 16);
    SetPcgMono(Char_Block, MonoChars + (Char_Block - Char_Logo) * CharHeight, 1, 4);
    SetPcgMono(Char_Item, MonoChars + (Char_Item - Char_Logo) * CharHeight, 6, 4);
    SetPcgMono(Char_Line_Normal, LineChars, 7, 8);
    SetPcgMono(Char_Line_Red, LineChars, 2, 8);
    SetPcgMono(Char_Fence, FenceChars, 1, 2);
    SetPcgColor(Char_Remain, ColorChars + 3 * CharHeight, 4);
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
