#include "VVram.h"
#include "Block.h"
#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    ClearVVram();
    DrawSprites();
    VVramToVram();
    BackgroundChanged = false;
}
