#include "Vram.h"

const byte[] CharColors = {
	1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 
	1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 
	1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 
	1 | 8, 1 | 8, 1 | 8, 1 | 8, 1 | 8, 3 | 8, 3 | 8, 3 | 8, 
	3 | 8, 3 | 8, 3 | 8, 3 | 8, 3 | 8, 3 | 8, 3 | 8, 3 | 8, 
	3 | 8, 3 | 8, 3 | 8, 3 | 8, 3 | 8, 3 | 8, 6 | 8, 6 | 8, 
	6 | 8, 6 | 8, 6 | 8, 6 | 8, 6 | 8, 6 | 8, 7 | 8, 7 | 8, 
	7 | 8, 7 | 8, 2 | 8, 2 | 8, 2 | 8, 2 | 8, 
};

ptr<byte> Put2C(ptr<byte> pVram, byte c)
{
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2 * VramStep;
    }
    return pVram + 2 - VramRowSize * 2;
}
