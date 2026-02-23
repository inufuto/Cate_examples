#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVram;
byte[3] RowFlags;


void DrawAll()
{
    EraseSprites();
    DrawSprites();
    VVramToVramChanged();
}
