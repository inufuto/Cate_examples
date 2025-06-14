#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"
#include "VVram.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 14;
constexpr byte MaxCount = 4; 
constexpr byte MaxTime = 6;
static const word[] Values = { 10, 20, 40, 80 };

struct Point {
    byte x, y;
    byte c;
    byte time;
};
Point[MaxCount] Points;
byte PointRate;

void InitPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->time = 0;
    }
}


void StartPoint(byte x, byte y)
{
    AddScore(Values[PointRate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            if (x > VVramWidth - 5) {
                x = VVramWidth - 5;
            }
            pPoint->x = x;
            pPoint->y = y;
            pPoint->c = Char_Point + (PointRate << 1);
            if (PointRate < 4 - 1) {
                ++PointRate;
            }
            return;
        }
    }
}


void UpdatePoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            --pPoint->time;
        }
    }
}


static ptr<byte> PutC(ptr<byte> pVVram, byte c)
{
    repeat (2) {
        pVVram = VPut(pVVram, c);
        pVVram += VVramWidth - 1;
        ++c;
    }
    return pVVram + 1 - VVramWidth * 2;
}

void DrawPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            ptr<byte> pVVram = VVramFront + VVramOffset(pPoint->x, pPoint->y);
            pVVram = PutC(pVVram, pPoint->c);
            byte c = Char_Point + 4 * 2;
            repeat (3) {
                pVVram = PutC(pVVram, c);
                c += 2;
            }
        }
    }
}