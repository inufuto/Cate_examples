#include "Vram.h"
#include "Chars.h"
#include "Star.h"
#include "Fort.h"
#include "Barrier.h"
#include "Sprite.h"

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


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        ClearBackground();
        DrawStars();
        DrawForts();
        DrawBarriers();
        SwitchPage();
    }
    UpdateSprites();
}


void BPut(byte x, byte y, byte c)
{
    if (x >= WindowWidth) return;
    if (y >= WindowHeight) return;
    WriteVram(VramOffset(x, y) + NextPage, c);
}


void BPut6(byte x, byte y, byte c)
{
    constexpr byte Size = 6;
    word vram = VramOffset(x + Size, y + Size) +
        NextPage - (VramRowSize * Size + Size * VramStep);
    repeat (Size) {
        if (y < WindowHeight) {
            repeat (Size) {
                if (x < WindowWidth) {
                    WriteVram(vram, c);
                }
                vram += VramStep;
                ++c;
                ++x;
            }
            vram += VramRowSize - Size * VramStep;
            x -= Size;
        }
        else {
            vram += VramRowSize;
            c += Size;
        }
        ++y;
    }
}
