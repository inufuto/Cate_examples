#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"

constexpr byte MaxCount = SpriteCount - Sprite_Point;
// const byte Color = 14;
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
    static const byte[] Chars = {
        0x21, Char_Cent, Char_Space, Char_Space,
        0x22, Char_Cent, Char_Space, Char_Space,
        0x24, Char_Cent, Char_Space, Char_Space,
        0x28, Char_Cent, Char_Space, Char_Space,
    };
    ptr<Movable> pPoint;
    AddScore(Values[rate]);
    for (pPoint: Points) {
        if ((pPoint->status & Movable_Status_Live) != 0) continue;
        pPoint->status |= Movable_Status_Live;
        pPoint->x = x;
        pPoint->y = y;
        pPoint->dx = Time;
        ShowSpriteS(pPoint, Chars + (rate << 2));
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
