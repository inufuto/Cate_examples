#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Sound.h"
#include "Stage.h"

byte [VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVVram();
    }
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
    CallSound();
}
