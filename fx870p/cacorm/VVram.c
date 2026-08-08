#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Point.h"

byte[VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    MapToVVram();
    DrawSprites();
    VVramToVram();
    DrawPoints();
    PresentVram();
    CallSound();
}
