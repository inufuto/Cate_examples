#include "VVram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Vram.h"
#include "Sound.h"
#include "Init.h"

byte[VVramWidth * VVramHeight] VVramFront;
byte[VVramWidth * VVramHeight] VVramBack;

void DrawAll()
{
    MapToBackGround();
    PollVSync();
    EraseFront();
    PollVSync();
    DrawSprites();
    PollVSync();
    VVramToVram();
    PollVSync();
    // CallSound();
}
