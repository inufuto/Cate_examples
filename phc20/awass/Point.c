#include "Point.h"
#include "Sprite.h"
#include "Chars.h"
#include "Main.h"

constexpr byte MaxTime = 6;

static const word[] Values = { 10, 20, 40, 80 };

Point[MaxPointCount] Points;

void InitPoints()
{
    byte sprite = Sprite_Point;
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->sprite = sprite;
        pPoint->time = 0;
        HideSprite(sprite);
        ++sprite;
    }
}


static void StartSprite(byte x, byte y, byte pattern)
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y;
            ShowSprite(pPoint, pattern);
            break;
        }
    }
}

void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    StartSprite(x - 1, y, Pattern_Point + rate);
    StartSprite(x + 1, y, Pattern_Point + 4);
}


void UpdatePoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time != 0) {
            if (--pPoint->time == 0) {
                HideSprite(pPoint->sprite);
            }
        }
    }
}
