#include "VVram.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

void DrawAll()
{
    MapToBackGround();
    BeginDraw();
    DrawSprites();
    EndDraw();
    CallSound();
}
