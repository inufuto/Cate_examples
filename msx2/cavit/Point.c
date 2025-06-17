#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"

constexpr byte MaxCount = Sprite_End - Sprite_Point;
const byte Color = 5;
constexpr byte Time = 6;
static const word[] Values = { 10, 20, 40, 80 };

Movable[MaxCount] Points;


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


void StartPoint(byte x, byte y, byte rate)
{
    ptr<Movable> pPoint;
    AddScore(Values[rate]);
    for (pPoint: Points) {
        if ((pPoint->status & Movable_Status_Live) != 0) continue;
        pPoint->status |= Movable_Status_Live;
        pPoint->x = x;
        pPoint->y = y;
        pPoint->dx = Time << CoordShift;
        ShowSpriteM(pPoint, Pattern_Point + (rate), Color);
        return;
    }
}


void UpdatePoints()
{
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        if ((pPoint->status & Movable_Status_Live) == 0) continue;
        if (pPoint->dx == 0) {
            pPoint->status = 0;
            HideSprite(pPoint->sprite);
        }
        else {
            --pPoint->dx;
        }
    }
}
