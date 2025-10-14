#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"

extern void PollVSync();

byte[VVramWidth * VVramHeight] VVram;


void DrawAll()
{
    MapToVVram();
    DrawSprites();
    VVramToVram();
    PollVSync();
}
