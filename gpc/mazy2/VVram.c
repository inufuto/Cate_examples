#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Point.h"
#include "Stage.h"
// #include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    MapToVVram();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    PresentVram();
    // CallSound();
}
