#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"
#include "Barrier.h"

bool VVramChanged;


void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        DrawFort();
        DrawBarriers();
        DrawSprites();
        // StatusToVVram();
        VVramToVramAll();
        VVramChanged = false;
    }
    else {
        EraseSprites();
        EraseBarriers();
        EraseFort();
        DrawFort();
        DrawBarriers();
        DrawSprites();
        // StatusToVVram();
        VVramToVramChanged();
    }
}
