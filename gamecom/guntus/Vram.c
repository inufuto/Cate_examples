#include "Vram.h"
#include "Chars.h"
#include "EnemyRow.h"
#include "Star.h"
#include "VVram.h"
#include "Sprite.h"

bool BackgroundChanged;

word Put2C(word vram, byte c)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
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


void DrawAll() 
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearVVram();
        DrawStars();
        DrawEnemyRows();
    }
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwapPage();
}
