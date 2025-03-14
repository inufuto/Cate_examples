#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"
#include "VVram.h"

constexpr byte RangeY = 32;
constexpr byte CharCount = CoordRate;

struct Star {
    byte x, y;
};

static const Star[] Stars = {
	{ 1, 15 },
	{ 22, 3 },
	{ 22, 26 },
	{ 16, 8 },
	{ 14, 20 },
	{ 10, 0 },
	{ 5, 29 },
	{ 9, 14 },
	{ 24, 5 },
	{ 1, 20 },
	{ 27, 14 },
	{ 6, 30 },
	{ 1, 27 },
	{ 29, 22 },
	{ 5, 26 },
	{ 18, 19 },
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
    CharOffset += 8 / CoordRate;
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
        if (y < VVramHeight) {
            *VVramPtr(x, y) = c;
        }
    }
}
