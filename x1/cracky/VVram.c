#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;
byte[4] RowFlags;

void DrawAll()
{
    EraseSprites();
    DrawSprites();
    VVramToVram();
}
