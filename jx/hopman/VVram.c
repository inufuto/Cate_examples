#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
// #include "Sound.h"
#include "Goal.h"

byte [VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVVram();
    }
    DrawGoal();
    BeginDraw();
    DrawSprites();
    EndDraw();
    // CallSound();
}
