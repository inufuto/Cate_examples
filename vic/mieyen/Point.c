#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"
#include "VVram.h"

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


void InitPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->time = 0;
    }
}


void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y - 1;
            pPoint->c = (rate << 1) + Char_Point;
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


void DrawPoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            byte c = pPoint->c;
            ptr<byte> pVVram = VVramPtr(pPoint->x, pPoint->y);
            pVVram[0] = c;
            pVVram[1] = c + 1;
        }
    }
}