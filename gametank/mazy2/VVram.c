#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    VVramToVram();
    PresentBackground();
    DrawSprites();
    EraseRightEnd();
    SwitchPage();
}
