#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"
#include "Fort.h"
// #include "Sound.h"

void DrawAll()
{
    EraseSprites();
    EraseForts();
    BackgroundToVram();
    DrawForts();
    DrawSprites();
    SwitchVram();
    // CallSound();
}
