#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}


ptr<byte> VPut2CXY(byte x, byte y, byte c)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            pVVram = VPut(pVVram, c);
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}

ptr<byte> VErase2XY(byte x, byte y)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            pVVram = VPut(pVVram, Char_Space);
        }
        pVVram += VVramWidth - 2;
    }
    return pVVram + 2 - VVramWidth * 2;
}