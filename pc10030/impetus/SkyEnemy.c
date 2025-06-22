#include "SkyEnemy.h"
#include "Sprite.h"
#include "Math.h"
#include "Main.h"
#include "Fighter.h"
#include "EnemyBullet.h"
#include "Stage.h"
#include "Bang.h"
#include "Main.h"
#include "Barrier.h"
#include "Sound.h"
#include "Item.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte Size = 1 * CoordRate;
constexpr byte Count = 3;
constexpr byte RangeX = VVramWidth * CoordRate - 1;
constexpr byte RangeY = VVramHeight * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte FireMask = CoordRate * 2 - 1;
constexpr byte TurnMask = CoordRate * 2 - 1;
constexpr byte HitMask = CoordMask >> 1;

constexpr byte Type_Crash = 0;
constexpr byte Type_Smart = 1;
constexpr byte Type_Insistent = 2;
constexpr byte Type_Barrier = 3;
constexpr byte Type_Count = 4;

constexpr byte Direction_Up = 0;
constexpr byte Direction_UpRight = 1;
constexpr byte Direction_Right = 2;
constexpr byte Direction_DownRight = 3;
constexpr byte Direction_Down = 4;
constexpr byte Direction_DownLeft = 5;
constexpr byte Direction_Left = 6;
constexpr byte Direction_UpLeft = 7;

struct Direction {
    sbyte dx, dy;
};
const Direction[] Directions = {
    { 0, -1 }, // Direction_Up
    { 1, -1 }, // Direction_UpRight
    { 1, 0 }, // Direction_Right
    { 1, 1 }, // Direction_DownRight
    { 0, 1 }, // Direction_Down
    { -1, 1 }, // Direction_DownLeft
    { -1, 0 }, // Direction_Left
    { -1, -1 }, // Direction_UpLeft
};

static const word[] Points = { 4, 6, 10 };
static const byte[] Paterns = { 
    Pattern_SkyEnemyA, Pattern_SkyEnemyB, Pattern_SkyEnemyC
};

SkyEnemy[Count] SkyEnemies;
static byte NextType;
static byte TypeBit;


void InitSkyEnemies()
{
    byte sprite;
    ptr<SkyEnemy> pEnemy;
    sprite = Sprite_SkyEnemy;
    for (pEnemy : SkyEnemies) {
        pEnemy->sprite = sprite;
        pEnemy->y = InvalidY;
        ++sprite;
    }
    NextType = 0;
    TypeBit = 1;
}


static void DecideDirection(ptr<SkyEnemy> pEnemy)
{
    switch (pEnemy->type) {
    case Type_Crash:
        {
            byte dx, dy;
            dx = Sign(pEnemy->x, FighterX);
            if (pEnemy->bulletCount == 0) {
                if (dx != 0) {
                    dx = -dx;
                }
                else {
                    dx = -1;
                }
            }
            pEnemy->dx = dx;
            pEnemy->dy = 1;
        }
        break;
    case Type_Smart: 
        {
            byte direction, diff;
            ptr<Direction> pDirection;

            if (FighterX < pEnemy->x) {
                if (FighterY < pEnemy->y) {
                    direction = Direction_UpLeft;
                }
                else if (FighterY == pEnemy->y) {
                    direction = Direction_Left;
                }
                else {
                    direction = Direction_DownLeft;
                }
            }
            else if (FighterX == pEnemy->x) {
                if (FighterY < pEnemy->y) {
                    direction = Direction_Up;
                }
                else {
                    direction = Direction_Down;
                }
            }
            else {
                if (FighterY < pEnemy->y) {
                    direction = Direction_UpRight;
                }
                else if (FighterY == pEnemy->y) {
                    direction = Direction_Right;
                }
                else {
                    direction = Direction_DownRight;
                }
            }
            if (pEnemy->bulletCount == 0) {
                direction = (direction + 4) & 7;
            }
            if (direction != pEnemy->direction) {
                diff = (direction - pEnemy->direction) & 7;
                if (diff <= 4) {
                    pEnemy->direction = (pEnemy->direction + 1) & 7;
                }
                else {
                    pEnemy->direction = (pEnemy->direction - 1) & 7;
                }
            }
            pEnemy->pattern = Pattern_SkyEnemyB + pEnemy->direction;
            pDirection = Directions + pEnemy->direction;
            pEnemy->dx = pDirection->dx;
            pEnemy->dy = pDirection->dy;
        }
        break;
    case Type_Insistent:
        {
            byte x, y;
            x = (Rnd() & 0x0f) << (1 + CoordShift);
            y = ((Rnd() & 0x0f) + 4) << CoordShift;
            pEnemy->dy = Sign(pEnemy->y, y);
            pEnemy->dx = Sign(pEnemy->x, x);
        }
        break;
    }
}


static void Show(ptr<SkyEnemy> pEnemy)
{
    ShowSprite(pEnemy->sprite, pEnemy->x, pEnemy->y, pEnemy->pattern);
}


static void End(ptr<SkyEnemy> pEnemy)
{
    pEnemy->y = InvalidY;
    HideSprite(pEnemy->sprite);
}


void StartSkyEnemy()
{
    ptr<SkyEnemy> pEnemy;

    if ((Rnd()) >= CurrentStage + 3) return;
    repeat (Type_Count) {
        TypeBit <<= 1;
        ++NextType;
        if (NextType >= Type_Count) {
            NextType = 0;
            TypeBit = 1;
        }
        if ((TypeBit & SkyElementBits) != 0) break;
    }
    if (NextType == Type_Barrier) {
        StartBarrier();
    }
    else {
        for (pEnemy : SkyEnemies) {
            if (pEnemy->y >= RangeY) {
                pEnemy->x = (Rnd() & 0x0f) << (1 + CoordShift);
                pEnemy->y = 0;
                pEnemy->type = NextType;
                pEnemy->pattern = Paterns[NextType];
                pEnemy->bulletCount = (CurrentStage + 1);
                pEnemy->direction = Direction_Down;
                pEnemy->clock = 0;
                DecideDirection(pEnemy);
                Show(pEnemy);
                return;
            }
        }
    }
}


void MoveSkyEnemies()
{
    ptr<SkyEnemy> pEnemy;
    for (pEnemy : SkyEnemies) {
        if (pEnemy->y >= RangeY) continue;
        
        ++pEnemy->clock;
        if (
            (pEnemy->clock & FireMask) == 0 &&
            (pEnemy->type == Type_Insistent || pEnemy->bulletCount > 0) &&
            (Rnd()) < CurrentStage + 2
        ) {
            if (StartEnemyBullet(pEnemy->x, pEnemy->y)) {
                --pEnemy->bulletCount;
            }
        }

        switch (pEnemy->type) {
        case Type_Crash:
            if ((pEnemy->y & 3) == 0) {
                pEnemy->x += pEnemy->dx;
                DecideDirection(pEnemy);
            }
            ++pEnemy->y;
            break;
        case Type_Smart:
        case Type_Insistent:
            if ((pEnemy->clock & TurnMask) == 0) {
                DecideDirection(pEnemy);
            }
            pEnemy->x += pEnemy->dx;
            pEnemy->y += pEnemy->dy;
            break;
        }
        if (
            pEnemy->x >= RangeX || pEnemy->y >= RangeY || 
            HitEnemyFighter(pEnemy->x, pEnemy->y)
        ) {
            End(pEnemy);
        }
        else {
            Show(pEnemy);
        }
    }
}


static void Destroy(ptr<SkyEnemy> pEnemy)
{
    // Sound_SmallBang();
    Sound_Hit();
    StartBang(pEnemy->x + Size, pEnemy->y + Size, false);
    End(pEnemy);
    AddScore(Points[pEnemy->type]);
}


bool HitBulletSkyEnemy(byte x, byte y)
{
    ptr<SkyEnemy> pEnemy;
    x += CoordRate - 1;
    for (pEnemy : SkyEnemies) {
        if (pEnemy->y >= RangeY) continue;
        if (
            x >= pEnemy->x && x < pEnemy->x + CoordRate * 2 &&
            y >= pEnemy->y && y < pEnemy->y + CoordRate * 2
        ) {
            if (
                y < VVramHeight / 2 * CoordRate &&
                RemainCount < 10 && 
                Rnd() == 0
            ) {
                StartItem(pEnemy->x, pEnemy->y);
            }
            Destroy(pEnemy);
            return true;    
        }
    }
    return false;
}
