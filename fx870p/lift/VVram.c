#include "VVram.h"
#include "Sound.h"
#include "Sprite.h"
#include "Vram.h"
#include "Point.h"

extern void _deb();

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    DrawBackGround();
    DrawSprites();
    VVramToVram();
    DrawPoints();
    PresentVram();
    CallSound();
}
