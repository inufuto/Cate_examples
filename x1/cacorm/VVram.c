#include "VVram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Init.h"

byte[VVramWidth * VVramHeight] VVramFront, VVramBack;


void DrawAll()
{
    MapToVVram();
    ClearFront();
    DrawSprites();
    VVramToVram();
}
