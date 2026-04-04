#include "VVram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Destruction.h"
#include "Stage.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll()
{
    MapToVVram();
    DrawDestructions();
    DrawSprites();
    VVramToVram();
    CallSound();
}
