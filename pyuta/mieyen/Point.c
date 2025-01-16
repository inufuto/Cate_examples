#include "Point.h"
#include "Sprite.h"
#include "Main.h"
#include "Chars.h"
#include "Vram.h"

constexpr byte SpriteColor = 14;
constexpr byte MaxCount = Sprite_End - Sprite_Point; 
constexpr byte MaxTime = 6;
static const word[] Values = { 10, 20, 40, 80 };

// Movable[MaxCount] Points;


void InitPoints()
{
    byte sprite = Sprite_Point;
    word pPoint = Points;
    repeat (MaxCount) {
        WriteVram(pPoint + Movable_status, 0);
        WriteVram(pPoint + Movable_sprite, sprite);
        HideSprite(sprite);
        ++sprite;
        pPoint += Movable_unitSize;
    }
}


void StartPoint(byte x, byte y, byte rate)
{
    AddScore(Values[rate]);
    word pPoint = Points;
    repeat (MaxCount) {
        if ((ReadVram(pPoint + Movable_status) & Movable_Live) != 0) goto next;
        WriteVram(pPoint + Movable_status, Movable_Live | MaxTime << CoordShift);
        WriteVram(pPoint + Movable_x, x);
        WriteVram(pPoint + Movable_y, y - CoordRate);
        ShowSprite(pPoint, Pattern_Point + rate, SpriteColor);
        return;
        next:
        pPoint += Movable_unitSize;
    }
}


void UpdatePoints()
{
    word pPoint = Points;
    repeat (MaxCount) {
        byte status = ReadVram(pPoint + Movable_status);
        if ((status & Movable_Live) == 0) goto next;
        byte time = status & ~Movable_Live;
        if (time == 0) {
            WriteVram(pPoint + Movable_status, 0);
            HideSprite(ReadVram(pPoint + Movable_sprite));
        }
        else {
            --time;
            WriteVram(pPoint + Movable_status, Movable_Live | time);
        }
        next:
        pPoint += Movable_unitSize;
    }
}
