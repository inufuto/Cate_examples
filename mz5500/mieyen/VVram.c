#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    BeginDraw();
    DrawSprites();
    EndDraw();
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


ptr<byte> VErase2(ptr<byte> pVVram) 
{
    repeat (2) {
        repeat (2) {
            *pVVram = Char_Space; ++pVVram;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}
