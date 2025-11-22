#include "Vram.h"
#include "VVram.h"
#include "Fort.h"
#include "Sprite.h"

void DrawAll()
{
    VVramToVram();
    UpdateOffset();
    PresentBackground();
    DrawForts();
    DrawSprites();
    PresentForeground();
    EraseRightEnd();
    SwitchPage();
}
