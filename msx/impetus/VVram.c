#include "VVram.h"
#include "Vram.h"
#include "Sprite.h"
#include "Barrier.h"
#include "Stage.h"
#include "Fort.h"

byte[VVramWidth * VVramHeight] VVram;
byte[3] RowFlags;
bool GroundChanged;


void DrawAll()
{
    if (GroundChanged) {
        GroundToVVram();
        DrawFort();
        DrawBarriers();
        StatusToVVram();
        VVramToVramAll();
        GroundChanged = false;
    }
    else {
        EraseBarriers();
        EraseFort();
        DrawFort();
        DrawBarriers();
        StatusToVVram();
        VVramToVramChanged();
    }
    RotateSprites();
    UpdateSprites();
}


void SetRowFlag(byte y)
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


// ptr<byte> VVramPtr(byte x, byte y)
// {
//     word w;
//     w = y;
//     return VVram + (w << 5) + x;
// }