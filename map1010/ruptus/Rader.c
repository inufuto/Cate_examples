#include "Rader.h"
#include "Vram.h"
#include "Fighter.h"

constexpr ptr<byte> LeftTop = Vram + VramRowSize * 12 + 24;

void PrintRader()
{
    ptr<byte> pVram;
    pVram= LeftTop;
    repeat(12 * CharHeight) {
        repeat(8) {
            *pVram = 0x55;
            ++pVram;
        }
        pVram += VramWidth - 8;
    }
}

static ptr<byte> VramPointerToRader(byte x, byte y)
{
    word w;
    w = y;
    w <<= 5;
    return LeftTop + w + x;
}

static void Plot(byte x, byte y, byte b)
{
    ptr<byte> pVram;
    byte shift, mask;
    
    shift = (x & 3) << 1;
    b >>= shift;
    mask = 0xff3f >> shift;

    pVram = VramPointerToRader(x >> 2, y);
    *pVram = (*pVram & mask) | b;
}

void DrawFortRader(byte x, byte y, bool visible)
{
    byte modX, modY, b;
    ptr<byte> pRader, pVram;
    x >>= 1;
    y &= 0xfe;
    b = visible ? 0xc0 : 0x40;
    repeat (4) {
        repeat (2) {
            Plot(x, y, b);
            ++x;
        }
        ++y;
        x -= 2;
    }
}


void DrawFighterOnRader()
{
    byte x, y, b, shift;
    ptr<byte> pVram;
    x = (FighterX - 1) >> 1;
    y = (FighterY - 1) & 0xfe;

    shift = (x & 3) << 1;
    b = 0xc0 >> shift;

    pVram = VramPointerToRader(x >> 2, y);
    pVram[0] ^= b;
    pVram[VramWidth] ^= b;
}
