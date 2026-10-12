#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Goal.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    MapToVVram();
    DrawGoal();
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}
