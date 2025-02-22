#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Sound.h"

byte [VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}
