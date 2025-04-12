#include "VVram.h"
#include "Destruction.h"
#include "Sprite.h"
#include "Vram.h"
// #include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    MapToVVram();
    DrawDestructions();
    DrawSprites();
    VVramToVram();
    // PresendVram();
    // CallSound();
}
