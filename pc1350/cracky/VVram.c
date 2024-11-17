#include "VVram.h"
#include "Destruction.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

extern void _deb();

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;
bool VVramChanged;

void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        VVramChanged = false;
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    CallSound();
}
