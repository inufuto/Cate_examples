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
    { Char_Logo, MonoChars + (Char_Logo - Char_Logo) * CharHeight, 16, 2 },
    { Char_Ladder, MonoChars + (Char_Ladder - Char_Logo) * CharHeight, 54, 3 },
    { Char_Fire, MonoChars + (Char_Fire - Char_Logo) * CharHeight, 32, 1 },
    { Char_Item_1Up, MonoChars + (Char_Item_1Up - Char_Logo) * CharHeight, 8, 2 },
    { Char_Item_1Up, MonoChars + (Char_Item_1Up - Char_Logo) * CharHeight, 12, 2 },
};

void InitVram()
{
    ptr<ColorRange> pColor;
    ClearScreen();
    for (pColor : ColorRanges) {
        MakePatternMono(pColor->c, pColor->p, pColor->count, pColor->color);
    }
    MakePatternColor(Char_Floor, ColorChars, Char_End - Char_Floor);
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
