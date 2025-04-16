#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"
// #include "Sound.h"

bool VVramChanged;


void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
    }
    else {
        EraseForts();
        EraseSprites();
    }
    DrawForts();
    DrawSprites();
    VVramToVram();
    // PresendVram();
    // CallSound();
}
