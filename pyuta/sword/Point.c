#include "Point.h"
#include "Sprite.h"
#include "Chars.h"
#include "Main.h"
#include "Vram.h"

constexpr byte PointColor = 14;
constexpr byte MaxTime = 6;

static const word[] Values = { 10, 20, 40, 80 };

// Point[PointSpriteCount] Points;
byte PointRate;

void InitPoints()
{
    byte sprite = Sprite_Point;
    word pPoint = Points;
    repeat (PointSpriteCount) {
        WriteVram(pPoint + Movable_sprite, sprite);
        WriteVram(pPoint + Point_time, 0);
        HideSprite(sprite);
        ++sprite;
        pPoint += Movable_unitSize;
    }
    PointRate = 0;
}


void StartPoint(byte x, byte y)
{
    AddScore(Values[PointRate]);
    word pPoint = Points;
    repeat (PointSpriteCount) {
        if (ReadVram(pPoint + Point_time) == 0) {
            WriteVram(pPoint + Point_time, MaxTime << CoordShift);
            WriteVram(pPoint + Movable_x, x);
            WriteVram(pPoint + Movable_y, y);
            ShowSprite(pPoint, Pattern_Point + PointRate, PointColor);
            ++PointRate;
            break;
        }
        pPoint += Movable_unitSize;
    }
}


void UpdatePoints()
{
    word pPoint = Points;
    repeat (PointSpriteCount) {
        byte time = ReadVram(pPoint + Point_time);
        if (time != 0) {
            --time;
            WriteVram(pPoint + Point_time, time);
            if (time == 0) {
                HideSprite(ReadVram(pPoint + Movable_sprite));
            }
        }
        pPoint += Movable_unitSize;
    }
}
