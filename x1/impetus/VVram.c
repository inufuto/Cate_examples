#include "VVram.h"
#include "Vram.h"
#include "Sprite.h"
#include "Barrier.h"
#include "Stage.h"
#include "Fort.h"

bool VVramChanged;

void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        DrawFort();
        DrawBarriers();
        ToVramAll();
        VVramChanged = false;
    }
    else {
        EraseBarriers();
        EraseFort();
        DrawFort();
        DrawBarriers();
        ToVramChanged();
    }
    EraseSprites();
    DrawSprites();
    ToGVram();
}


// void SetRowFlag(byte y)
// {
//     ptr<byte> pFlags;
//     byte bits;
//     pFlags = GRowFlags + (y >> 3);
//     bits = ((byte)1) << (y & 7);
//     *pFlags |= bits;
//     bits <<= 1;
//     if (bits == 0) {
//         ++pFlags;
//         bits = 1;
//     }
//     *pFlags |= bits;
// }
// ptr<byte> VVramPtr(byte x, byte y)
// {
//     word w;
//     w = y;
//     return VVram + (w << 5) + x;
// }
