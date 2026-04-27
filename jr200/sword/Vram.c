#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
// #include "Sound.h"

void DrawAll() 
{    
    VVramBackToFront();
    DrawSprites();
    VVramToVram();
    // CallSound();
}

ptr<byte> Put2C(ptr<byte> pVram, byte c, byte color)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c, color);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space, 0x07);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}
