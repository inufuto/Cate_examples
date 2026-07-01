#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVram;

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
