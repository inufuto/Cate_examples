#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"
#include "Barrier.h"
#include "Fort.h"
#include "Sound.h"

void DrawAll()
{
    EraseBarriers();
    EraseFort();
    EraseSprites();
    DrawGround();
    DrawFort();
    DrawBarriers();
    DrawSprites();
    SwitchVram();
    // CallSound();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
}


void Put2(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(vram, c);
            ++c;
            vram += VramStep;
        }
        vram += VramRowSize - 2 * VramStep;
    }
}
