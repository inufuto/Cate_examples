#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

void DrawAll() {    
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
}
