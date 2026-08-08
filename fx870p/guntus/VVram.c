#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "EnemyRow.h"
#include "Star.h"
#include "Sound.h"

extern void _deb();

bool BackgroundChanged;

void DrawAll() 
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearVVram();
        // DrawStars();
        DrawEnemyRows();
        VVramBackToFront();
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    CallSound();
    PresentVram();
                            _deb();
}


ptr<byte> VPut2S(ptr<byte> pVVram, ptr<byte> pChars)
{
    repeat (2) {
        repeat (2) {
            *pVVram = *pChars; ++pVVram;
            ++pChars;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}