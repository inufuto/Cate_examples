#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"
#include "Fort.h"
#include "Sound.h"

void DrawAll()
{
    EraseSprites();
    BackgroundToVram();
    DrawForts();
    DrawSprites();
    SwitchTVram();
    SwitchGVram();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}
