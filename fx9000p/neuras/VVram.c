#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"

byte[VVramWidth * VVramHeight] VVramBack;
byte[VVramWidth * VVramHeight] VVramFront;
bool VVramChanged;

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
        DrawSprites();
        VVramToVram();
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVram();
    }
}


void VErase2(byte x, byte y)
{
    ptr<byte> pVVram;
    pVVram =  VVramBack + VVramOffset(x - 1, y);
    pVVram[0] = Char_Wall;
    pVVram[1] = Char_Wall;
    pVVram[VVramWidth] = Char_Wall;
    pVVram[VVramWidth + 1] = Char_Wall;
}


void VPut2(byte x, byte y, byte c)
{
    ptr<byte> pVVram;
    pVVram =  VVramBack + VVramOffset(x - 1, y);
    pVVram[0] = c++;
    pVVram[1] = c++;
    pVVram[VVramWidth] = c++;
    pVVram[VVramWidth + 1] = c++;
}
