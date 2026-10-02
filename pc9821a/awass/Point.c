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


void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y;
            ShowSprite(pPoint, Pattern_Point + rate);
            break;
        }
    }
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
