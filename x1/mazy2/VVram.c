#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    ClearVVram();
    DrawSprites();
    VVramToVram();
}
