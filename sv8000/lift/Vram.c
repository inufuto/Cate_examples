#include "Vram.h"
#include "Stage.h"
#include "Sprite.h"
#include "Lift.h"

void DrawAll()
{
    EraseSprites();
    DrawLiftBottoms();
    DrawSprites();
    FlushVBuffer();
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}
