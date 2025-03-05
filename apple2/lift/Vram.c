#include "Vram.h"
#include "VVram.h"
#include "CopyMemory.h"
#include "Chars.h"

extern byte[] Backup;

static const byte[] ColorSource = {
    Char_Space, 1, 0x00,
    Char_Floor, 1, 0x00,
    Char_Item_A, 4, 0x00,
    Char_Item_C, 4, 0x00,
    0xff
};

byte[256] CharColors;

static void SetColor(ptr<byte> pColor, byte color, byte count)
{
    do {
        *pColor = color;
        ++pColor;
        --count;
    } while (count != 0);
}

void InitVram()
{
    ptr<byte> pColor, pSource;

    pColor = CharColors;
    repeat (Char_End) {
        *pColor = 0x80;
        ++pColor;
    }

    pSource = ColorSource;
    while (pSource[0] != 0xff) {
        byte count, color;
        pColor = CharColors + pSource[0];
        count = pSource[1];
        color = pSource[2];
        pSource += 3;
        do {
            *pColor = color;
            ++pColor;
            --count;
        } while (count > 0);
    }
}


void ClearScreen()
{
    FillMemory(Vram, 0x2000, 0);
    FillMemory(Backup, VVramWidth * VVramHeight, 0);
}
