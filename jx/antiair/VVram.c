#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Sound.h"
#include "Stage.h"

byte [VVramWidth * VVramHeight] VVram;
bool BackgroundChanged;

void DrawGround()
{
    ptr<byte> pVVram;
    pVVram = VVram + VVramWidth * 22;
    repeat (VVramWidth) {
        *pVVram = Char_Fence;
        ++pVVram;
    }
}