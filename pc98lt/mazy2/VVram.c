#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() 
{
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}
