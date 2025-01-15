#include "Vram.h"
#include "Chars.h"

extern void _deb();

byte PrintC(byte x, byte y, byte c)
{
    return Put(x, y, c - ' ');
}


byte Put2C(byte x, byte y, byte c)
{
    repeat (2) {
        repeat (2) {
            x = Put(x, y, c);
            ++c;
        }
        x -= 2;
        ++y;
    }
    return x + 2;
}


byte Erase2(byte x, byte y)
{
    repeat (2) {
        repeat (2) {
            x = Put(x, y, Char_Space);
        }
        x -= 2;
        ++y;
    }
    return x + 2;
}
