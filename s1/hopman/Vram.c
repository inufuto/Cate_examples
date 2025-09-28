#include "Vram.h"
#include "Chars.h"
#include "Movable.h"
#include "Sprite.h"


void DrawAll()
{
    EraseSprites();
    DrawSprites();
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVram();
        SwitchTVram();
    }
    SwitchGVram();
}


ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - ' ');
}


ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}
