#include "Vram.h"
#include "VVram.h"
#include "Sprite.h"
#include "Fort.h"
#include "Sound.h"

void DrawAll()
{
    EraseSprites();
    BackgroundToVVram();
    DrawForts();
    VVramToVram();
    DrawSprites();
    SwitchVram();
    CallSound();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}
