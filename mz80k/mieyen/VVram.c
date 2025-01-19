#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Point.h"
#include "Stage.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    DrawBackground();
    DrawSprites();
    DrawPoints();
    VVramToVram();
}
