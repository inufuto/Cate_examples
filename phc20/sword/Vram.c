#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Sound.h"
#include "Stage.h"

void DrawAll() 
{    
    DrawStage();
    DrawSprites();
    VVramToVram();
    CallSound();
}


ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    pVram = Put3L(pVram, c); ++c;
    pVram = Put3R(pVram, c); ++c;
    pVram += VramRowSize3 - 1;
    pVram = Put2L(pVram, c); ++c;
    pVram = Put2R(pVram, c); ++c;
    return pVram - VramRowSize3;
}


ptr<byte> Erase2(ptr<byte> pVram)
{
    pVram = Put3L(pVram, 0);
    pVram = Put3R(pVram, 0);
    pVram += VramRowSize3 - 1;
    pVram = Put2L(pVram, 0);
    pVram = Put2R(pVram, 0);
    return pVram - VramRowSize3;
}