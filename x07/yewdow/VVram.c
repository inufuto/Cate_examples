#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"

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
