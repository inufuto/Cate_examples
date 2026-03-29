#include "Star.h"
#include "Vram.h"
#include "Chars.h"
#include "Coord.h"

constexpr byte RangeY = 32;
constexpr byte CharCount = 8;

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
byte CharOffset;

void MoveStars()
{
    CharOffset += CoordRate / 4;
    if (CharOffset >= CharCount) {
        CharOffset -= CharCount;
        ++YOffset;
        BackgroundChanged = true;
    }
    else {
        DrawStars(ForegoundAddress());
    }
}


void DrawStars(word vram)
{
    byte c, old;
    ptr<Star> pStar;
    c = Char_Star + CharOffset;
    for (pStar : Stars) {
        byte x, y;
        word v;
        x = pStar->x;
        y = (pStar->y + YOffset) & (RangeY - 1);
        if (y < WindowHeight) {
            v = VramOffset(x, y) + vram;
            old = ReadVram(v);
            if (old == Char_Space || (old >= Char_Star && old < Char_Star + CharCount)) {
                WriteVram(v, c);
            }
        }
    }
}
