#include "VVram.h"
#include "Block.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Point.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    DrawBackground();
    DrawBlocks();
    DrawSprites();
    VVramToVram();
    DrawPoints();
    PresentVram();
    CallSound();
}
