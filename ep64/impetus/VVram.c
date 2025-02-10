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
        VVramChanged = false;
        VVramBackToFront();
        DrawFort();
        DrawBarriers();
        DrawSprites();
    }
    else {
        EraseSprites();
        EraseBarriers();
        EraseFort();
        DrawFort();
        DrawBarriers();
        DrawSprites();
    }
    VVramToVram();
}
