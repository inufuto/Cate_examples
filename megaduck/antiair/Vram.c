#include "Vram.h"
#include "Chars.h"
#include "Ufo.h"
#include "Block.h"

extern void _deb();

bool BackgroundChanged;

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - ' ');
}


void DrawAll() {
    if (BackgroundChanged) {
        BackgroundChanged = false;
        UfoMoved = false;
        ptr<byte> pVram = NextPage();
        DrawBackground(pVram);
        DrawUfos(pVram);
        SwitchPage();
    }
    else if (UfoMoved) {
        UfoMoved = false;
        DrawUfos(CurrentPage());
    }
}


ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            c += 2;
        }
        c -= 3;
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
