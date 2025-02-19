#include "Vram.h"
#include "VVram.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sprite.h"

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawGround();
        DrawBarriers();
        DrawFort();
    }
    EraseSprites();
    StatusToVVram();
    VVramToVram();
    DrawSprites();
    SwitchVram();
}
