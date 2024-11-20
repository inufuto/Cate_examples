#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Goal.h"

extern void _deb();

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;
bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVVram();
        DrawGoal();
        VVramBackToFront();
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    CallSound();
}
