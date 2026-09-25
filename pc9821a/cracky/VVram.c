#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"

byte [VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
}
