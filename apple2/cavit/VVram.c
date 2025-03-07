#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "CopyMemory.h"

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;
byte[3] RowFlags;


void Put4C(byte x, byte y, byte c)
{
    ptr<byte> pVVram;
    pVVram = VVramBack + VVramOffset(x, y);
    repeat (2) {
        repeat (2) {
            *pVVram = c;
            ++c;
            ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
    VVramChanged = true;
}


void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        DrawSprites();
        VVramToVramAll();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVramChanged();
    }
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


void ClearVVram()
{
    FillMemory(VVramBack, VVramWidth * VVramHeight, 0);
}
