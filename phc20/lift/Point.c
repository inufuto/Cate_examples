#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"

constexpr byte Count = SpriteCount - Sprite_Point;

constexpr byte Time = 6;
constexpr byte InvalidY = 0xff;
static const word[] Values = { 10, 20, 40, 80 };

Movable[Count] Points;


void InitPoints()
{
    ptr<Movable> pPoint;
    byte sprite;
    sprite = Sprite_Point;
    for (pPoint: Points) {
        pPoint->y = InvalidY;
        pPoint->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


static void Start(byte x, byte y, byte pattern)
{
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        if (pPoint->y != InvalidY) continue;
        pPoint->x = x;
        pPoint->y = y;
        pPoint->clock = Time << CoordShift;
        ShowSprite(pPoint, pattern);
        return;
    }
}

void StartPoint(byte x, byte y, byte rate)
{
    ptr<Movable> pPoint;
    AddScore(Values[rate]);
    Start(x - 1, y, Char_Point + (rate << 2));
    Start(x + 1, y, Char_Point + 4 * 4);
}


void UpdatePoints()
{
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        if (pPoint->y == InvalidY) continue;
        if (pPoint->clock == 0) {
            pPoint->y = InvalidY;
            HideSprite(pPoint->sprite);
        }
        else {
            --pPoint->clock;
        }
    }
}
