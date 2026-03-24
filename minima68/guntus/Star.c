#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"

constexpr byte RangeY = 32;
constexpr byte CharCount = 4;

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
static byte CharOffset;

void InitStarts()
{
    YOffset = 0;
    CharOffset = 0;
    DrawStars();
}


void MoveStars()
{
    CharOffset += 8 * 2 / CoordRate;
    if (CharOffset >= CharCount) {
        CharOffset -= CharCount;
        ++YOffset;
    }
    BackgroundChanged = true;
}


void DrawStars()
{
    byte c, old;
    ptr<Star> pStar;
    c = Char_Star + CharOffset;
    for (pStar : Stars) {
        byte x, y;
        ptr<byte> pVVram;
        x = pStar->x;
        y = (pStar->y + YOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            *(pNextPage + VramOffset(x, y)) = c;
        }
    }
}
