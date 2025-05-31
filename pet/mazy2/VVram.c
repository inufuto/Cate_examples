#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
// #include "Sound.h"
#include "Point.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll() {    
    VVramBackToFront();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    // CallSound();
}
