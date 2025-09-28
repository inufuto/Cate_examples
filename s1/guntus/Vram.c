#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "CopyMemory.h"
#include "Sound.h"
#include "Star.h"
#include "EnemyRow.h"

bool BackgroundChanged;

void DrawAll()
{
    EraseSprites();
    DrawSprites();
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearNextPage();
        DrawStars();
        DrawEnemyRows();
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


ptr<byte> Erase2(ptr<byte> pVram)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 * VramStep - VramRowSize * 2;
}
