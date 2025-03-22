#include "Vram.h"
#include "Chars.h"
#include "VVram.h"
#include "Star.h"
#include "EnemyRow.h"

bool BackgroundChanged;

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


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearVVram();
        DrawStars();
        DrawEnemyRows();
        VVramToVram();
    }
}
