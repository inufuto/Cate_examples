#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "CopyMemory.h"

extern byte[] Backup;

static const byte[] ColorSource = {
    Char_EnemyC, 32, 0x00,
    Char_Item, 4, 0x00,
    0xff
};

byte[256] CharColors;

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


void Put2C(byte x, byte y, byte c)
{
    repeat (2) {
        Locate(x, y);
        repeat (2) {
            Put(c);
            ++c;
        }
        ++y;
    }
}


void Erase2(byte x, byte y)
{
    repeat (2) {
        Locate(x, y);
        repeat (2) {
            Put(Char_Space);
        }
        ++y;
    }
}
