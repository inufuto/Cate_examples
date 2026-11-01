#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fort.h"

extern void _deb();

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawGround();
        DrawForts();
    }
    BeginDraw();
    DrawSprites();
    EndDraw();
}
