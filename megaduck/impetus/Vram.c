#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Barrier.h"
#include "Fort.h"
#include "Stage.h"

bool BackgroundChanged;

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void DrawAll()
{
    if (BackgroundChanged) {
        charOffset ^= TerrainCharCount;
        RollChar();
        GroundToVram();
        DrawFort(NextPage);
        DrawBarriers(NextPage);
        StatusToVram(NextPage);
        SwitchPage();
        BackgroundChanged = false;
        BarrierChanged = false;
        FortChanged = false;
    }
    else if (BarrierChanged) {
        DrawBarriers(CurrentPage);
        StatusToVram(CurrentPage);
        BarrierChanged = false;
    }
    else if (FortChanged) {
        DrawFort(CurrentPage);
        StatusToVram(CurrentPage);
        FortChanged = false;
    }
    UpdateSprites();
}
