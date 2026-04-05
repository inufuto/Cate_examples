#include "Vram.h"
#include "VVram.h"
#include "Item.h"
#include "Sprite.h"
#include "Sound.h"

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    pVram = Put3L(pVram, c); ++c;
    pVram = Put3R(pVram, c); ++c;
    pVram += VramRowSize3 - 1;
    pVram = Put2L(pVram, c); ++c;
    pVram = Put2R(pVram, c); ++c;
    return pVram - VramRowSize3;
}


void DrawAll()
{
    MapToVVram();
    DrawItems();
    DrawSprites();
    VVramToVram();
    CallSound();
}
