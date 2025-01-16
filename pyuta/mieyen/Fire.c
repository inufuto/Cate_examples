#include "Fire.h"
#include "Sprite.h"
#include "Sound.h"
#include "Chars.h"
#include "Man.h"
#include "Monster.h"
#include "Point.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 13;
constexpr byte Fire_Moving = 0x40;
constexpr byte Fire_PointMask = 0x30;
constexpr byte MaxCount = Sprite_Point - Sprite_Fire;

static const byte[4] SpriteColors = { 8, 11, 10, 9 };
// Fire[MaxCount] Fires;
byte FireTime;
static byte Clock;

void InitFires()
{
    byte sprite = Sprite_Fire;
    word pFire = Fires;
    repeat (MaxCount) {
        WriteVram(pFire + Movable_status, 0);
        WriteVram(pFire + Movable_sprite, sprite);
        ++sprite;
        pFire += Fire_unitSize;
    }
}


void StartFire()
{
    word pFire = Fires;
    repeat (MaxCount) {
        if ((ReadVram(pFire + Movable_status) & Movable_Live) == 0) {
            WriteVram(pFire + Movable_status, Movable_Live | Fire_Moving);
            WriteVram(pFire + Movable_x, ReadVram(Man + Movable_x));
            WriteVram(pFire + Movable_y, ReadVram(Man + Movable_y));
            WriteVram(pFire + Movable_dx, pManDirection->dx);
            WriteVram(pFire + Movable_dy, pManDirection->dy);
            WriteVram(pFire + Fire_time, FireTime);
            Sound_Fire();
            break;
        }
        pFire += Fire_unitSize;
    }
}


static bool Hit(word pFire)
{
    word pMonster = HitMonster(pFire);
    if (pMonster != 0) {
        byte status = ReadVram(pFire + Movable_status);
        byte rate = status & Fire_PointMask;
        StartPoint(ReadVram(pMonster + Movable_x), ReadVram(pMonster + Movable_y), rate >> 4);
        WriteVram(pFire + Movable_status, (status & ~Fire_PointMask) | ((rate + 0x10) & Fire_PointMask));
        Sound_Hit();
        return true;
    }
    return false;
}

void MoveFires()
{
    word pFire = Fires;
    repeat (MaxCount) {
        byte status = ReadVram(pFire + Movable_status);
        if ((status & Movable_Live) != 0) {
            byte pattern;
            if ((status & Fire_Moving) != 0) {
                if (((ReadVram(pFire + Movable_x) | ReadVram(pFire + Movable_y)) & CoordMask) == 0) {
                    byte time = ReadVram(pFire + Fire_time);
                    --time;
                    WriteVram(pFire + Fire_time, time);
                    if (
                        time == 0 || 
                        !CanMove(pFire, ReadVram(pFire + Movable_dx), ReadVram(pFire + Movable_dy))
                    ) {
                        status &= ~Fire_Moving;
                        WriteVram(pFire + Movable_status, status);
                        WriteVram(pFire + Fire_time, FireTime << 2);
                        pattern = Pattern_Fire;
                        goto show;
                    }
                }
                MoveMovable(pFire);
                pattern = Pattern_FireBullet;
            }
            else {
                if ((Clock & CoordMask) == 0) {
                    byte time = ReadVram(pFire + Fire_time);
                    --time;
                    WriteVram(pFire + Fire_time, time);
                    if (time == 0) {
                        status &= ~Movable_Live;
                        WriteVram(pFire + Movable_status, status);
                        HideSprite(ReadVram(pFire + Movable_sprite));
                        goto next;
                    }
                }
                pattern = Pattern_Fire;
            }
            show:
            ShowSprite(pFire, pattern, SpriteColors[(Clock >> CoordShift) & 3]);
            Hit(pFire);
        }
        next:
        pFire += Fire_unitSize;
    }
    ++Clock;
}