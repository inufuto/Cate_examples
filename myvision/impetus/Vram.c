#include "Vram.h"
#include "Stage.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sprite.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        GroundToVram();
        DrawFort();
        DrawBarriers(NextPage);
        StatusToVram();
        SwitchVram();
    }
    else {
        DrawBarriers(CurrentPage);
    }
    RotateSprites();
    UpdateSprites();
}