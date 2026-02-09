#include "Vram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"
#include "Sound.h"

void DrawAll()
{
    EraseSprites();
    PresentVram();
    DrawSprites();
    SwapScreen();
}

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            Put(pVram, c);
            ++c;
            pVram += VramStep;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 *VramStep - VramRowSize * 2;
}
