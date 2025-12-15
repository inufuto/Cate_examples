#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Fort.h"

extern void _deb();

void DrawAll()
{
    VVramBackToFront();
    DrawForts();
    DrawSprites();
    VVramToVram();
}
