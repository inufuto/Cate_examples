#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "EnemyRow.h"
#include "Star.h"
// #include "Sound.h"

bool BackgroundChanged;

// void ClearVVram()
// {
//     FillMemory(VVramBack, VVramWidth * VVramHeight, 0);
// }


void DrawAll() 
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearVVram();
        DrawStars();
        DrawEnemyRows();
        VVramBackToFront();
    }
    else {
        EraseSprites();
    }
    DrawSprites();
    VVramToVram();
    // CallSound();
    // PresendVram();
}


ptr<byte> VPut2C(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        repeat (2) {
            *pVVram = c; ++pVVram;
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}