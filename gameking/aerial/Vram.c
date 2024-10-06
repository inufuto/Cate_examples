#include "Vram.h"
#include "VVram.h"
#include "Fort.h"

extern void _deb();

bool BackgroundChanged;

ptr<byte> Put2S(ptr<byte> pVram, ptr<byte> pChars, bool right)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, *pChars, right);
            right = !right;
            ++pChars;
        }
        pVram += VramRowSize - 1;
    }
    return pVram - VramRowSize * 2 + 1;
}


void DrawAll()
{
    if (BackgroundChanged) {
        BackgroundChanged = false;
        GroundToVVram();
        if (FortCount != 0) {
            DrawForts();
        }
        VVramToVram();
    }
    PresentVram();
}
