#include "Vram.h"
#include "VVram.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sprite.h"


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawGround();
        DrawBarriers();
        DrawFort();
    }
    BeginDraw();
    DrawSprites();
    EndDraw();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}
