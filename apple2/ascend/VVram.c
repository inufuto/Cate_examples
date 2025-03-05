#include "VVram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    MapToBackGround();
    DrawSprites();
    VVramToVram();
    CallSound();
}
