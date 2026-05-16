#include "Point.h"
#include "Sprite.h"
#include "Main.h"

constexpr byte MaxTime = 6;

static const word[] Values = { 10, 20, 40, 80 };
static const byte[] Chars = {
    0x31, 0x30, 0x20, 0x30,        
    0x32, 0x30, 0x20, 0x30,
    0x34, 0x30, 0x20, 0x30,
    0x38, 0x30, 0x20, 0x30,
};

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
    }
}


void StartPoint(byte x, byte y)
{
    AddScore(Values[PointRate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y;
            ShowSprite(pPoint, Chars + (PointRate << 2));
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
            }
        }
    }
}
