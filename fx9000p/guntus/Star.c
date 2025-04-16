#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"
#include "VVram.h"

constexpr byte RangeY = 32;

struct Star {
    byte x, y;
};

static const Star[] Stars = {
	{ 4, 22 },
	{ 8, 24 },
	{ 14, 27 },
	{ 4, 22 },
	{ 9, 19 },
	{ 4, 18 },
	{ 0, 21 },
	{ 10, 20 },
	{ 8, 19 },
	{ 12, 14 },
	{ 3, 28 },
	{ 4, 27 },
	{ 15, 17 },
	{ 11, 8 },
	{ 10, 15 },
	{ 12, 9 },
};

static byte YOffset;

void MoveStars()
{
    ++YOffset;
    BackgroundChanged = true;
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
            pv = VVramBack + VVramOffset(x, y);
            *pv = Char_Star;
        }
    }
}
