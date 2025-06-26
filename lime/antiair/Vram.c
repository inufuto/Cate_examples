#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Ufo.h"
#include "Block.h"
#include "Sprite.h"

extern void _deb();

bool BackgroundChanged;

void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        DrawBackground();
        DrawUfos();
    }
    EraseSprites();
    VVramToVram();
    DrawSprites();
    SwitchVram();
}


word PrintC(word vram, byte c)
{
    Put(vram, c - ' ');
    return vram + VramStep;
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


word Erase2(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2;
    }
    return vram + 2 - VramRowSize * 2;
}
