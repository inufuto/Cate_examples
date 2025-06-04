#include "Vram.h"
#include "Sprite.h"

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
    return pVram - VramRowSize * 2 + 2 * VramStep;
}


void DrawAll()
{
    DrawSprites();
    SwitchPage();
}
