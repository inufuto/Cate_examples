#include "Star.h"
#include "Fighter.h"
#include "VVram.h"
#include "Chars.h"

struct Star {
    byte x, y;
};

static const Star[] Stars = {
    { 81, 19 },
    { 23, 56 },
    { 10, 43 },
    { 115, 25 },
    { 100, 36 },
    { 37, 88 },
    { 80, 60 },
    { 54, 9 },
    { 71, 66 },
    { 116, 80 },
    { 2, 52 },
    { 117, 41 },
    { 86, 48 },
    { 65, 44 },
    { 45, 38 },
    { 34, 5 },
    // { 31, 93 },
    // { 7, 37 },
    // { 46, 47 },
    // { 19, 45 },
    // { 32, 60 },
    // { 69, 15 },
    // { 120, 62 },
    // { 64, 37 },
    // { 13, 75 },
    // { 58, 72 },
    // { 76, 79 },
    // { 2, 20 },
    // { 9, 10 },
    // { 42, 12 },
    // { 0, 51 },
    // { 84, 52 },
};

void DrawStars() 
{
    constexpr byte rangeX = 128;
    constexpr byte rangeY = 96;
    ptr<Star> pStar;
    byte baseX, baseY;

    baseX = FighterX;
    baseY = FighterY;
    while (baseY > rangeY) {
        baseY -= rangeY;
    }

    for (pStar : Stars) {
        byte x, y, xMod, yMod, c;
        x = pStar->x - baseX;
        while (x >= rangeX) {
            x -= rangeX;
        }
        y = (pStar->y + rangeY) - baseY;
        while (y >= rangeY) {
            y -= rangeY;
        }
        xMod = x & 3;
        yMod = y & 3;
        x >>= 2;
        y >>= 2;
        c = Char_Star + (yMod << 2) + xMod;
        VPut1(x, y, c);
    }
}