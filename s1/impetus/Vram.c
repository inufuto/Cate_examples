#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Barrier.h"
#include "Fort.h"

bool BackgroundChanged;

word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}


void DrawAll()
{
    EraseSprites();
    DrawSprites();
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawGround();
        DrawFort();
        DrawBarriers();
        SwitchTVram();
    }
    SwitchGVram();
}
