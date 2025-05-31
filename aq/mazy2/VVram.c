#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Sound.h"
#include "Point.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll() {    
    VVramBackToFront();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    CallSound();
}
