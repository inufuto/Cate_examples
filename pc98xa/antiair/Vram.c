#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Ufo.h"
#include "Block.h"
#include "Sprite.h"

extern void _deb();

void DrawAll()
{
    if (BackgroundChanged || UfoMoved) {
        BackgroundChanged = false;
        DrawBackground();
        DrawUfos();
    }
    BeginDraw();
    DrawSprites();
    EndDraw();
}
