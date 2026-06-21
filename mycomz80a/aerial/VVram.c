#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Fort.h"

bool VVramChanged;

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        VVramBackToFront();
    }
    else {
        EraseForts();
        EraseSprites();
    }
    DrawForts();
    DrawSprites();
    VVramToVram();
}
