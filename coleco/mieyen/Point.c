#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"

constexpr byte SpriteColor = 14;
constexpr byte MaxCount = Sprite_End - Sprite_Point; 
constexpr byte MaxTime = 6;
static const word[] Values = { 10, 20, 40, 80 };

Movable[MaxCount] Points;


void InitPoints()
{
    byte sprite = Sprite_Point;
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        pPoint->status = 0;
        pPoint->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
    }
}


void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        if ((pPoint->status & Movable_Live) != 0) continue;
        pPoint->status = Movable_Live | MaxTime << CoordShift;
        pPoint->x = x;
        pPoint->y = y;
        ShowSprite(pPoint, Pattern_Point + rate, SpriteColor);
        return;
    }
}


void UpdatePoints()
{
    ptr<Movable> pPoint;
    for (pPoint: Points) {
        byte status = pPoint->status;
        if ((status & Movable_Live) == 0) continue;
        byte time = status & ~Movable_Live;
        if (time == 0) {
            pPoint->status = 0;
            HideSprite(pPoint->sprite);
        }
        else {
            --time;
            pPoint->status = Movable_Live | time;
        }
    }
}
