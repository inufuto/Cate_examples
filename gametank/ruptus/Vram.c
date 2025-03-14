#include "Vram.h"
#include "Chars.h"
#include "Star.h"
#include "Fort.h"
#include "Barrier.h"
#include "Sprite.h"

void DrawAll()
{
    if (VVramChanged) {
        VVramChanged = false;
        ClearVVram();
        DrawStars();
        DrawForts();
        DrawBarriers();
    }
    VVramToVram();
    PresentBackground();
    DrawSprites();
    EraseRightEnd();
    SwitchPage();
    // CallSound();
}


void Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}

void Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
}

void Put4S(word vram, ptr<byte> pBytes)
{
    repeat(4) {
        repeat(4) {
            vram = Put(vram, *pBytes);
            ++pBytes;
        }
        vram += VramRowSize - 4 * VramStep;
    }
}