#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fort.h"

extern void _deb();

void DrawAll()
{
    VVramToVram();
    DrawForts();
    EraseSprites();
    DrawSprites();
    SwitchVram();
    PollVSync();
}
