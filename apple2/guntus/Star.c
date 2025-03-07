#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"
#include "VVram.h"

constexpr byte RangeY = 32;
// constexpr byte CharCount = 2;

struct Star {
    byte x, y;
};

static const Star[] Stars = {
	{ 0, 1 },
	{ 15, 27 },
	{ 8, 24 },
	{ 22, 25 },
	{ 3, 26 },
	{ 19, 6 },
	{ 20, 10 },
	{ 10, 8 },
	{ 14, 0 },
	{ 8, 23 },
	{ 9, 14 },
	{ 2, 12 },
	{ 5, 31 },
	{ 19, 15 },
	{ 16, 13 },
	{ 18, 18 },
};

static byte YOffset;
// byte CharOffset;

void MoveStars()
{
    ++YOffset;
}


void DrawStars()
{
    ptr<Star> pStar;
    for (pStar : Stars) {
        byte x, y;
        ptr<byte> pv;
        x = pStar->x;
        y = (pStar->y + YOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            pv = VVramPtr(x, y);
            *pv = Char_Star;
        }
    }
}
