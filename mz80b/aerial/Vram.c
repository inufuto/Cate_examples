#include "Vram.h"
#include "Chars.h"

extern byte[] Backup;
extern byte[] MonoPattern, ColorPattern, AsciiPattern;


word PrintC(word vram, byte c)
{
    VPut(vram, c - ' ');
    return vram + VramStep;
}
