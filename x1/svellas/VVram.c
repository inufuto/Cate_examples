#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
// #include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    ClearVVram();
    DrawSprites();
    VVramToVram();
    // CallSound();
}
