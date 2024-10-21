#include "Vram.h"
#include "Chars.h"
#include "EnemyRow.h"
#include "Star.h"

bool BackgroundChanged;

word PrintC(word vram, byte c)
{
    return Put(vram, c - ' ');
}


word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            c += 2;
        }
        vram += VramRowSize - 2 * VramStep;
        c += 1 - 4;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + 2 * VramStep - VramRowSize * 2;
}


void DrawAll() {
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearBackground();
        DrawStars();
        DrawEnemyRows();
        SwitchPage();
    }
}
