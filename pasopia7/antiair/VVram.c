#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"

bool VVramChanged;


void DrawAll()
{
    if (VVramChanged) {
        VVramBackToFront();
        DrawForts();
        DrawSprites();
        VVramToVramAll();
        VVramChanged = false;
    }
    else {
        EraseForts();
        EraseSprites();
        DrawForts();
        DrawSprites();
        VVramToVramChanged();
    }
}
