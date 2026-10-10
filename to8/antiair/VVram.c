#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Ufo.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() 
{
    DrawBackground();
    DrawUfos();
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}
