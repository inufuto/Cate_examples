#include "Vram.h"

ptr<byte> PrintC(ptr<byte> pVram, byte c)
{
    return Put(pVram, c - ' ');
}
