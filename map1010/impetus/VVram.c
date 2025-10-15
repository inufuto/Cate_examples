#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"
#include "Barrier.h"
#include "Stage.h"
#include "Init.h"

void DrawAll()
{
    DrawGround();
    DrawFort();
    DrawBarriers();
    DrawSprites();
    // StatusToVVram();
    WaitTimer(1);
    VVramToVramAll();
}
