#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"

constexpr byte Count = Sprite_End - Sprite_Point;
const byte Color = 14;
constexpr byte Time = 6;
static const word[] Values = { 10, 20, 40, 80 };

Movable[Count] Points;


void InitPoints()
{
    ptr<Movable> pPoint;
    byte sprite;
    sprite = Sprite_Point;
    for (pPoint: Points) {
        pPoint->status = 0;
        pPoint->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


static void Start(byte x, byte y, byte pattern)
{
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        if ((pPoint->status & Movable_Live) != 0) continue;
        pPoint->status |= Movable_Live;
        pPoint->x = x;
        pPoint->y = y;
        pPoint->clock = Time;
        ShowSprite(pPoint, pattern);
        return;
    }
}

void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    Start(x - 1, y, Char_Point + (rate << 2));
    Start(x + 1, y, Char_Point + 4 * 4);
}


void UpdatePoints()
{
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        if ((pPoint->status & Movable_Live) == 0) continue;
        if (pPoint->clock == 0) {
            pPoint->status = 0;
            HideSprite(pPoint->sprite);
        }
        else {
            --pPoint->clock;
        }
    }
}
