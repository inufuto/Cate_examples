#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Fort.h"
// #include "Sound.h"

void DrawAll()
{
    BackgroundToVVram();
    DrawForts();
    BeginDraw();
    DrawSprites();
    EndDraw();
    // CallSound();
}
