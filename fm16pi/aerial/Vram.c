#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Fort.h"

void DrawAll()
{
    BackgroundToVVram();
    DrawForts();
    BeginDraw();
    DrawSprites();
    EndDraw();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}
