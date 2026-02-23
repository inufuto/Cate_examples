#include "Vram.h"
#include "Chars.h"

extern byte[] MonoChars, ColorChars, Ascii;


void InitVram()
{
    ClearScreen();

    SetPcgMono(Char_Ascii, Ascii, 7, Char_Logo - Char_Ascii);
    SetPcgMono(Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 5, 16);
    SetPcgMono(Char_Fence, MonoChars + (Char_Fence - Char_Logo) * CharHeight, 1, 2);
    SetPcgColor(Char_Wall, ColorChars, Char_End - Char_Wall);
}


void VPut2S(word vram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            VPut(vram, *pChars);
            ++pChars;
            ++vram;
        }
        vram += VramWidth - 2;
    }
}


void VPut2C(byte x, byte y, byte c)
{
    word vram;
    vram = VramAddress(x, y);
    repeat (2) {
        repeat (2) {
            VPut(vram, c);
            ++c;
            ++vram;
        }
        vram += VramWidth - 2;
    }
}
