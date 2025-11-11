#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fort.h"

extern void _deb();

void DrawAll()
{
    VVramBackToFront();
    DrawForts();
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
}
