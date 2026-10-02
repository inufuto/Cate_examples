#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"

void DrawAll()
{
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 *VramStep - VramRowSize * 2;
}
