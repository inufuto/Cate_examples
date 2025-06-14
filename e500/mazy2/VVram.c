#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Point.h"
#include "Sound.h"
                #include "Print.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll() 
{
    VVramBackToFront();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    PresentVram();
    CallSound();
}
