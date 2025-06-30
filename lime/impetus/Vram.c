#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "VVram.h"
#include "CopyMemory.h"
#include"Fort.h"
#include "Barrier.h"

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
        DrawFort();
        DrawBarriers();
    }
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
}


word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}
