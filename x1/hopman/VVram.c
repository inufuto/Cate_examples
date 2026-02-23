#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Goal.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;
bool VVramChanged;

void DrawAll()
{
    EraseSprites();
    MapToVVram();
    DrawGoal();
    DrawSprites();
    VVramToVram();
    // CallSound();
}
