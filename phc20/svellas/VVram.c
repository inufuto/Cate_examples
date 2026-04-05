#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Stage.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;

void DrawAll() {    
    MapToVVram();
    DrawSprites();
    VVramToVram();
    CallSound();
}
