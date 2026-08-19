#include "Fire.h"
#include "Sprite.h"
#include "Man.h"
#include "Chars.h"
#include "Monster.h"
#include "Stage.h"
#include "Main.h"
#include "Sound.h"
#include "ScanKeys.h"

constexpr byte InvlidY = 0xe0;
constexpr byte FireInterval = CoordRate * 8 - 1;

static const byte[4] SpriteColors = { 8, 11, 10, 9 };
Fire[FireSpriteCount] Fires;
byte FireTime;
static byte KeyCount;

void InitFires()
{
    byte sprite = Sprite_Fire;
    ptr<Fire> pFire;
    for (pFire : Fires) {
        pFire->y = InvlidY;
        pFire->sprite = sprite;
        ++sprite;
    }
    KeyCount = 0;
}


static bool Hit(ptr<Fire> pFire)
{
    ptr<Monster> pMonster = HitMonster(pFire);
    if (pMonster != nullptr) {
        pFire->y = InvlidY;
        AddScore(10);
        Sound_Hit();
        return true;
    }
    return false;
}


void MoveFires()
{
    ptr<Fire> pFire;
    for (pFire: Fires) {
        if (pFire->y != InvlidY) {
            if (((pFire->x | pFire->y) & CoordMask) == 0) {
                if (
                    --pFire->time == 0 || 
                    !CanMove(pFire, pFire->dx, 0)
                ) {
                    hide:
                    pFire->y = InvlidY;
                    HideSprite(pFire->sprite);
                    goto next;
                }
            }
            pFire->x += pFire->dx;
            ShowSprite(pFire, Pattern_Fire, SpriteColors[pFire->x & 3]);
            if (((pFire->x | pFire->y) & CoordMask) == 0) {
                if (Hit(pFire)) goto hide;
                byte column = pFire->x >> CellCoordShift;
                byte row = pFire->y >> CellCoordShift;
                byte cell = GetCell(column, row);
                if ((cell & Cell_Debri) != 0) {
                    Sound_Push();
                    SetCell(column, row, cell & ~Cell_Debri);
                    AddScore(2);
                    goto hide;
                }
            }
        }
        next:;
    }
    if ((Man.y & CoordMask) ==0 && (ScanKeys() & Keys_Button0) != 0) {
        if (KeyCount == 0) {
            KeyCount = FireInterval;
            sbyte dx = pManDirection->dx;
            if (dx == 0) return;

            ptr<Fire> pFire;
            for (pFire: Fires) {
                if (pFire->y == InvlidY) {
                    pFire->x = Man.x;
                    pFire->y = Man.y;
                    pFire->dx = dx;
                    pFire->time = FireTime;
                    Sound_Fire();
                    break;
                }
            }
        }
        else {
            --KeyCount;
        }
    }
    else {
        KeyCount = 0;
    }
}