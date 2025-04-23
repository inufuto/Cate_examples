#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[] Backup;

extern byte[] MonoChars, ColorChars, Ascii;

struct ColorRange {
    byte c;
    ptr<byte> p;
    byte count;
    byte color;
};
static const ColorRange[] ColorRanges = {
    { Char_Ascii, Ascii, 0x40, 3 },
    { Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16 + 8 + 1, 2 },
    { Char_Ladder, MonoChars + (Char_Ladder - Char_Logo) * CharHeight, 2 + 4 * 13, 3 },
    { Char_Monster, MonoChars + (Char_Monster - Char_Logo) * CharHeight, 4 * 8, 1 },
};

void InitVram()
{
    ptr<ColorRange> pColor;
    ClearScreen();
    for (pColor : ColorRanges) {
        MakePatternMono(pColor->c, pColor->p, pColor->count, pColor->color);
    }
    MakePatternColor(Char_Item, ColorChars, 4);
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
