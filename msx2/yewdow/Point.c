#include "Movable.h"
#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"

const byte Color = 7;
constexpr byte Count = 2;
constexpr byte InvalidY = 0xe0;
constexpr byte Time = 6;
static const word[] Values = { 10, 20, 40, 80 };

Point[Count] Points;


void InitPoints()
{
    ptr<Point> pPoint;
    byte sprite;
    sprite = Sprite_Point;
    for (pPoint: Points) {
        pPoint->_.y = InvalidY;
        pPoint->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


void StartPoint(byte x, byte y, byte rate)
{
    ptr<Point> pPoint;
    if (rate >= 4) rate = 3;
    AddScore(Values[rate]);
    for (pPoint: Points) {
        if (pPoint->_.y == InvalidY) {
            pPoint->_.x = x;
            pPoint->_.y = y;
            pPoint->clock = Time << CoordShift;
            ShowSpriteM(&pPoint->_, Pattern_Point + rate, Color);
            UpdateSprites();
            return;
        }
    }
}


void UpdatePoints()
{
    ptr<Point> pPoint;
    for (pPoint: Points) {
        if (pPoint->_.y != InvalidY) {
            if (pPoint->clock == 0) {
                pPoint->_.y = InvalidY;
                HideSprite(pPoint->_.sprite);
            }
            else {
                --pPoint->clock;
            }
        }
    }
}
