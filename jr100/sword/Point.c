#include "Point.h"
#include "Sprite.h"
#include "Chars.h"
#include "Main.h"

constexpr byte MaxTime = 6;

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
    }
}


void StartPoint(byte x, byte y)
{
    static const byte[] Chars = {
        0x11, 0x00, 0x10, 0x10,
        0x12, 0x00, 0x10, 0x10,
        0x14, 0x00, 0x10, 0x10,
        0x18, 0x00, 0x10, 0x10,
    };
    AddScore(Values[PointRate]);
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->time == 0) {
            pPoint->time = MaxTime << CoordShift;
            pPoint->x = x;
            pPoint->y = y;
            ShowSpriteS(pPoint, Chars + (PointRate << 2));
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
