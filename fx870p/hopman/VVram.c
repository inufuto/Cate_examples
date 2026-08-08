#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Goal.h"
#include "Sound.h"  

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    MapToVVram();
    DrawGoal();
    DrawSprites();
    VVramToVram();
    PresentVram();
    CallSound();
}
