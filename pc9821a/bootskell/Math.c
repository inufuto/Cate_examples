#include "Math.h"

constexpr byte RndCount = 32;

static const byte[RndCount] Numbers = {
    26, 30, 1, 16, 9, 13, 12, 5, 
    14, 15, 27, 7, 4, 3, 24, 20, 
    8, 18, 22, 10, 19, 21, 23, 6, 
    2, 29, 28, 11, 31, 0, 17, 25, 
};
byte RndIndex;

byte Rnd()
{
    byte r;
    r = Numbers[RndIndex];
    ++RndIndex;
    if (RndIndex >= RndCount) {
        RndIndex = 0;
    }
    return r & 0x0f;
}


byte Abs(byte a, byte b)
{
    if (a < b) {
        return b - a;
    }
    else {
        return a - b;
    }
}

sbyte Sign(byte from, byte to)
{
    if (from == to) {
        return 0;
    }
    if (from < to) {
        return 1;
    }
    return -1;
}