#include "VVram.h"
#include "Sound.h"
#include "Sprite.h"
#include "Vram.h"
#include "Point.h"

extern void _deb();

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


void DrawAll()
{
    DrawBackGround();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    CallSound();
}
