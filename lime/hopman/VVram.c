#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Goal.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    EraseSprites();
    MapToVVram();
    DrawGoal();
    VVramToVram();
    DrawSprites();
    SwitchVram();
    // CallSound();
}
