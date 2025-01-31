#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

byte[VVramWidth * VVramHeight] VVramBack, VVramFront;
byte[4] RowFlags;
bool VVramChanged;

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
        DrawSprites();
        VVramToVramAll();
    }
    else {
        EraseSprites();
        DrawSprites();
        VVramToVramChanged();
    }
}
