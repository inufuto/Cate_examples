#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"

byte [VVramWidth * VVramHeight] VVram;

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
