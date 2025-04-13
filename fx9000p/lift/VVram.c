#include "VVram.h"
// #include "Sound.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    DrawBackGround();
    DrawSprites();
    VVramToVram();
    // PresendVram();
    // CallSound();
}
