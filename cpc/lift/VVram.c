#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    DrawBackGround();
    DrawSprites();
    VVramToVram();
}
