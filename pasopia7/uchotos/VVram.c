#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
// #include "Sound.h"

byte[VVramWidth * (VVramHeight + 1)] VVram;

void DrawAll()
{
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
    // CallSound();
}

void VPut2CXY(byte x, byte y, byte c)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            pVVram = VPut(pVVram, c);
            ++c;
        }
        pVVram += VVramWidth - 2;
    }
}

void VPut2SXY(byte x, byte y, ptr<byte> pChars)
{
    ptr<byte> pVVram = VVramPtr(x, y);
    repeat (2) {
        repeat (2) {
            pVVram = VPut(pVVram, *pChars);
            ++pChars;
        }
        pVVram += VVramWidth - 2;
    }
}