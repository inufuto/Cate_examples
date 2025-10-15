#include "VVram.h"
#include "Block.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    DrawBackground();
    DrawBlocks();
    DrawSprites();
    VVramToVram();
}
