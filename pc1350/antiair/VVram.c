#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Ufo.h"

extern void _deb();

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;
bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawBackground();
        DrawUfos();
        VVramBackToFront();
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    CallSound();
}
