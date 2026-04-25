#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"

void DrawAll()
{    
    DrawStage();
    DrawSprites();
    VVramToVram();
}
