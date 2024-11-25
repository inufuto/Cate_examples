#include "VVram.h"
#include "Block.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Point.h"

byte[VVramWidth * VVramHeight] VVram;

ptr<byte> VPrintS(ptr<byte> pVVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVVram = VPrintC(pVVram, c);
        ++p;
    }
    return pVVram;
}

void DrawAll() {    
    DrawBackground();
    DrawBlocks();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    CallSound();
}
