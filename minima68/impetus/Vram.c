#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Barrier.h"
#include "Fort.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        GroundCharOffset ^= TerrainCharCount;
        UpdateGroundChars();
        GroundToVram();
        DrawFort();
        DrawBarriers(pNextPage);
        StatusToVram();
        SwitchPage();
    }
    else {
        DrawBarriers(pCurrentPage);
    }
}
