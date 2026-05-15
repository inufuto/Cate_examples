#include "Point.h"
#include "Sprite.h"
#include "Chars.h"
#include "Main.h"
#include "VVram.h"

constexpr byte MaxTime = 6;
constexpr byte RangeX = (VVramWidth - 4) * CoordRate;

static const word[] Values = { 10, 20, 40, 80 };

Point[PointSpriteCount] Points;
byte PointRate;

void InitPoints()
{
    byte sprite = Sprite_Point;
    ptr<Point> pPoint;
    for (pPoint: Points) {
        pPoint->sprite = sprite;
        pPoint->time = 0;
        HideSprite(sprite);
        ++sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


void StartPoint(byte x, byte y)
{
    AddScore(Values[PointRate]);
    if (x >= RangeX + 1) {
        x = RangeX;
    }
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y;
            Movable m;
            m.x = x + CoordRate * 2;
            m.y = y;
            m.sprite = pPoint->sprite + 1;
            ShowSprite(pPoint, Pattern_Point + 1 + PointRate);
            ShowSprite(&m, Pattern_Point);
            ++PointRate;
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
                HideSprite(pPoint->sprite + 1);
            }
        }
    }
}
