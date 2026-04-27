#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;

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
