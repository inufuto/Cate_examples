#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Ufo.h"
#include "Sound.h"

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
    DrawUfos();
    DrawSprites();
    VVramToVram();
    CallSound();
}
