#include "VVram.h"
#include "Sprite.h"
#include "Vram.h"
#include "Ufo.h"
#include "Sound.h"

byte[VVramWidth * VVramHeight] VVram;
bool BackgroundChanged;

void DrawAll() {    
    DrawBackground();
    DrawUfos();
    DrawSprites();
    VVramToVram();
    CallSound();
}
