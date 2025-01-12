#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Stage.h"
#include "Point.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    DrawBackground();
    DrawSprites();
    DrawPoints();
    VVramToVram();
}
