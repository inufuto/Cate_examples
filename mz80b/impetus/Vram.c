#include "Vram.h"
#include "Chars.h"

extern byte[] Backup;
extern byte[] MonoPattern, ColorPattern, AsciiPattern;


void InitVram()
{
    ClearScreen();
}


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + VramStep;
}
