#include "VVram.h"
#include "Vram.h"
#include "Sprite.h"

byte [VVramWidth * VVramHeight] VVram;
bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVVram();
    }
    BeginDraw();
    DrawSprites();
    EndDraw();
}
