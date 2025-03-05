#include "Vram.h"
#include "Chars.h"

void Put2(byte x, byte y, byte c)
{
    repeat (2) {
        Locate(x, y);
        repeat (2) {
            Put(c);
            ++c;
        }
        ++y;
    }
}


void Erase2(byte x, byte y)
{
    repeat (2) {
        Locate(x, y);
        repeat (2) {
            Put(Char_Space);
        }
        ++y;
    }
}
