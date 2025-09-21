#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"

constexpr ptr<byte> LeftTop = Vram + VramRowSize * 10 + 16 * VramStep;

void PrintRader()
{
    ptr<byte> pVram = LeftTop;
    repeat (12) {
        *pVram = 0xb0; ++pVram;
    }
    pVram += VramRowSize - 12;
    repeat (10) {
        repeat (12) {
            *pVram = 0xff; ++pVram;
        }
        pVram += VramRowSize - 12;
    }
    
    // byte i;
    // for (i = 0; i < 12; ++i) {
    //     ResetDot(i,i);
    // }
}

void DrawFortRader(byte x, byte y, bool visible)
{
    x >>= 2; x &= 0xfe;
    y >>= 2; y &= 0xfe;
    if (visible) {
        repeat(2) {
            repeat(2) {
                ResetDot(x, y);
                ++x;
            }
            ++y;
            x -= 2;
        }
    }
    else {
        repeat(2) {
            repeat(2) {
                SetDot(x, y);
                ++x;
            }
            ++y;
            x -= 2;
        }
    }
}

void DrawFighterOnRader()
{
    byte x = (FighterX - 1) >> 2;
    byte y = ((FighterY - 1) >> 2) & 0x1f;
    if (x >= 12) {
        x -= 12;
    }
    InvertDot(x, y);
}