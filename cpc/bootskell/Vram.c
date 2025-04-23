#include "Vram.h"
#include "VVram.h"
#include "Chars.h"

extern byte[] Backup;

extern byte[] Chars;

static const byte[] ColorBytes = {
	64,3,
	16,2,
	2,2,
	4,3,
	36,2,
	48,3,
	48,1,
	16,3,
    0
};

void InitVram()
{
    ClearScreen();
    {
        ptr<byte> pPattern, pColor;
        byte c, count, color;
        pColor = ColorBytes;
        pPattern = Chars;
        c = 0;
        while ((count = *pColor++) != 0) {
            color = *pColor;
            MakePatternMono(c, pPattern, count, color);
            c += count;
            pPattern += ((word)count) << 3;
            ++pColor;
        }
    }
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + 2;
}
