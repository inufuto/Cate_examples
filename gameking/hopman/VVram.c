#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
// #include "Sound.h"
#include "Stage.h"

extern void _deb();

byte [VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVVram();
    }
    VVramToVram();
    PresentVram();
    // CallSound();
                        _deb();
}
