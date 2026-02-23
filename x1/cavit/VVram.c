#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;
byte[3] RowFlags;


void DrawAll()
{
    EraseSprites();
    DrawSprites();
    VVramToVramChanged();
}


void SetRowFlags(byte y)
{
    ptr<byte> pFlags;
    byte bits;
    pFlags = RowFlags + (y >> 3);
    bits = ((byte)1) << (y & 7);
    *pFlags |= bits;
    bits <<= 1;
    if (bits == 0) {
        ++pFlags;
        bits = 1;
    }
    *pFlags |= bits;
}
