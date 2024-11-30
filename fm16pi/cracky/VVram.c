#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Sound.h"

byte [VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
}
