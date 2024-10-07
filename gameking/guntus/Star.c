#include "Star.h"
#include "Vram.h"
#include "VVram.h"
#include "Chars.h"
#include "Coord.h"

constexpr byte RangeY = 32;

struct Star {
    byte x, y;
};

static const Star[] Stars = {
	{ 17, 7 },
	{ 5, 11 },
	{ 19, 3 },
	{ 15, 28 },
	{ 1, 31 },
	{ 10, 2 },
	{ 9, 24 },
	{ 6, 4 },
	{ 5, 23 },
	{ 8, 20 },
	{ 19, 20 },
	{ 18, 17 },
	{ 16, 0 },
	{ 1, 21 },
	{ 15, 25 },
	{ 10, 23 },
};

static byte YOffset;
static byte StarDotOffset;


void InitStars()
{
    YOffset = 0;
    StarDotOffset = 0;
    BackgroundChanged = true;
}

void MoveStars()
{
    ++StarDotOffset;
    if (StarDotOffset >= CoordRate) {
        StarDotOffset = 0;
        ++YOffset;
    }
    BackgroundChanged = true;
}


void DrawStars()
{
    static const byte[] Chars = {
    	0x10, 0x01,
    };
    byte c = Chars[StarDotOffset];
    ptr<Star> pStar;
    for (pStar : Stars) {
        byte x, y;
        x = pStar->x;
        y = (pStar->y + YOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            *VVramPtr(x, y) = c;
        }
    }
}
