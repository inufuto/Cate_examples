#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"
#include "Barrier.h"
#include "Stage.h"
#include "Sound.h"

void DrawAll()
{
    DrawGround();
    DrawFort();
    DrawBarriers();
    DrawSprites();
    VVramToVram();
    StatusToVram();
    CallSound();    
}
