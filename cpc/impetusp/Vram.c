#include "Vram.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fort.h"
// #include "Sound.h"

extern void _deb();

void DrawAll()
{
    BeginDraw();
    DrawForts();
    DrawSprites();
    EndDraw();
    // CallSound();
}
