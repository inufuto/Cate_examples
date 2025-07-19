#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Goal.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;
bool VVramChanged;

void DrawAll()
{
    MapToVVram();
    DrawGoal();
    DrawSprites();
    VVramToVram();
    PresentVram();
    CallSound();
}
