#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"

void DrawAll()
{
    BeginDraw();
    DrawSprites();
    EndDraw();
}
