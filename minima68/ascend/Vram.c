#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        MapToVram();
        SwitchPage();
    }
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
    return pVram + 2 - VramRowSize * 2;
}
