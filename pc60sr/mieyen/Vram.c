#include "Vram.h"

extern void _deb();

word PrintC(word yx, byte c)
{
    return Put(yx, c - ' ');
}


word Put2C(word yx, byte c)
{
    repeat (2) {
        repeat (2) {
            yx = Put(yx, c);
            ++c;
        }
        yx += YStep - 2 * XStep;
    }
    return yx + 2 * XStep - YStep * 2;
}
