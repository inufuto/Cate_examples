#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Sound.h"
#include "Flag.h"

void DrawAll() 
{    
    DrawFloors();
    DrawFlags();
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
