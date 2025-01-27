#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Point.h"
#include "Stage.h"
#include "Sound.h"

byte[VVramWidth * (VVramHeight + 1)] VVram;

void DrawAll() {    
    DrawBackground();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    CallSound();
}
