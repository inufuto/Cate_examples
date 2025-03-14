#include "Vram.h"
#include "VVram.h"
#include "Fort.h"
#include "Sprite.h"

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        GroundToVVram();
    }
    VVramToVram();
    PresentBackground();
    if (FortCount != 0) {
        DrawForts();
    }
    DrawSprites();
    EraseRightEnd();
    SwitchPage();
}
