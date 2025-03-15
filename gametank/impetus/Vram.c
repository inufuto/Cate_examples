#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Status.h"
#include "Stage.h"
#include "Barrier.h"

void DrawAll()
{
    if (GroundChanged) {
        GroundChanged = false;
        DrawGround();
    }
    VVramToVram();
    UpdateOffset();
    PresentBackground();
    DrawFort();
    DrawBarriers();
    DrawSprites();
    PresentForeground();
    EraseRightEnd();
    SwitchPage();
}
