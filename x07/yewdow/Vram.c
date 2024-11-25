#include "Vram.h"
#include "VVram.h"
#include "Item.h"
#include "Sprite.h"
#include "Sound.h"
#include "Point.h"

void DrawAll()
{
    MapToVVram();
    DrawItems();
    DrawSprites();
    DrawPoints();
    VVramToVram();
    CallSound();
}

void DrawFence()
{
    word yx = Vram + 8;
    repeat (4) {
        PrintC(yx, Char_Fence);
        yx += VramRowSize;
    }
}