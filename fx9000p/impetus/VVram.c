#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"
#include "Barrier.h"
#include "Stage.h"
// #include "Sound.h"

void DrawAll()
{
    // FillMemory(VVram, VVramWidth * VVramHeight, 0xff);
    DrawGround();
    DrawFort();
    DrawBarriers();
    DrawSprites();
    // StatusToVVram();
    VVramToVram();
    // PresendVram();
    // CallSound();    
}
