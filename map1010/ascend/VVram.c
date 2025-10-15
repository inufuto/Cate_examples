#include "VVram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    MapToBackGround();
    DrawSprites();
    VVramToVram();
}
