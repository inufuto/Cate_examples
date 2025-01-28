#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Point.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    EraseSprites();
    VVramToVram();
    DrawSprites();
    DrawPoints();
    PresentVram();
    CallSound();
}
