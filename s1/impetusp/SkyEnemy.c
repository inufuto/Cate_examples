#include "SkyEnemy.h"
#include "Sprite.h"
#include "Chars.h"
#include "Main.h"
#include "Math.h"
#include "Stage.h"
#include "Vram.h"
#include "Fighter.h"
#include "Bang.h"
#include "Sound.h"
#include "EnemyBullet.h"
#include "Barrier.h"
#include "Item.h"

extern void _deb();

constexpr byte Size = 1 * CoordRate;
constexpr byte InitialY = -CoordRate * 2;
constexpr byte RangeX = (WindowWidth - 2) * CoordRate + 1;
constexpr byte RangeY = WindowHeight * CoordRate;
constexpr byte InvalidY = WindowHeight * CoordRate;
constexpr byte FireMask = CoordRate - 1;
constexpr byte TurnMask = CoordRate * 2 - 1;

constexpr byte Type_Crash = 0;
constexpr byte Type_Smart = 1;
constexpr byte Type_Insistent = 2;
constexpr byte Type_Barrier = 3;
constexpr byte Type_Count = 4;
constexpr byte TypeMask = 0x07;

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
static const Direction[] Directions = {
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

SkyEnemy[MaxSkyEnemyCount] SkyEnemies;
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

static void Show(ptr<SkyEnemy> pEnemy)
{
    ShowSprite(pEnemy, pEnemy->pattern + Pattern_SkyEnemy);
}

static void End(ptr<SkyEnemy> pEnemy)
{
    pEnemy->y = InvalidY;
    HideSprite(pEnemy->sprite);
}

static void DecideDirection(ptr<SkyEnemy> pEnemy)
{
    switch (pEnemy->type) {
    case Type_Crash:
        {
            sbyte dx = Sign(pEnemy->x, Fighter.x);
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
            byte direction;
            if (pEnemy->y >= InitialY) {
                direction = Direction_Down;
            }
            else if (Fighter.x < pEnemy->x) {
                if (Fighter.y < pEnemy->y) {
                    direction = Direction_UpLeft;
                }
                else if (Fighter.y == pEnemy->y) {
                    direction = Direction_Left;
                }
                else {
                    direction = Direction_DownLeft;
                }
            }
            else if (Fighter.x == pEnemy->x) {
                if (Fighter.y < pEnemy->y) {
                    direction = Direction_Up;
                }
                else {
                    direction = Direction_Down;
                }
            }
            else {
                if (Fighter.y < pEnemy->y) {
                    direction = Direction_UpRight;
                }
                else if (Fighter.y == pEnemy->y) {
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
                byte diff = (direction - pEnemy->direction) & 7;
                if (diff <= 4) {
                    pEnemy->direction = (pEnemy->direction + 1) & 7;
                }
                else {
                    pEnemy->direction = (pEnemy->direction - 1) & 7;
                }
            }
            pEnemy->pattern = pEnemy->direction + (Pattern_SkyEnemyB - Pattern_SkyEnemy);
            ptr<Direction> pDirection = Directions + pEnemy->direction;
            pEnemy->dx = pDirection->dx;
            pEnemy->dy = pDirection->dy;
        }
        break;
    case Type_Insistent:
        {
            if (pEnemy->y >= InitialY) {
                pEnemy->dy = 1;
                pEnemy->dx = 0;
            }
            else {
                byte x = (Rnd() & 0x0f) << (1 + CoordShift);
                byte y = ((Rnd() & 0x0f) + 4) << CoordShift;
                pEnemy->dy = Sign(pEnemy->y, y);
                pEnemy->dx = Sign(pEnemy->x, x);
            }
        }
        break;
    }
}

void StartSkyEnemy()
{
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
        ptr<SkyEnemy> pEnemy;
        for (pEnemy : SkyEnemies) {
            if (pEnemy->y == InvalidY) {
                static const byte[] Paterns = { 
                    Pattern_SkyEnemyA - Pattern_SkyEnemy,
                    Pattern_SkyEnemyB - Pattern_SkyEnemy,
                    Pattern_SkyEnemyC - Pattern_SkyEnemy,
                };
                pEnemy->x = (Rnd() & 0x0f) << (1 + CoordShift);
                pEnemy->y = InitialY;
                byte type = NextType;
                pEnemy->pattern = Paterns[type];
                pEnemy->type = type;
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
        if (pEnemy->y != InvalidY) {
            ++pEnemy->clock;
            if (
                (pEnemy->clock & FireMask) == 0 &&
                (pEnemy->type == Type_Insistent || pEnemy->bulletCount > 0) &&
                (Rnd()) < CurrentStage + 3
            ) {
                byte y = pEnemy->y;
                if (
                    y < RangeY &&
                    StartEnemyBullet(pEnemy->x, y)
                ) {
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
                pEnemy->x >= RangeX || 
                pEnemy->y - InitialY >= RangeY - InitialY || 
                HitEnemyFighter(pEnemy->x, pEnemy->y)
            ) {
                End(pEnemy);
            }
            else {
                Show(pEnemy);
            }
        }
    }
}


bool HitBulletSkyEnemy(byte x, byte y)
{
    ptr<SkyEnemy> pEnemy;
    x += CoordRate - 1;
    for (pEnemy : SkyEnemies) {
        if (pEnemy->y != InvalidY) {
            if (HitEnemy(pEnemy, x, y)) {
                if (
                    y < WindowHeight / 3 * CoordRate &&
                    RemainCount < 10 && 
                    Rnd() == 0
                ) {
                    StartItem(pEnemy->x, pEnemy->y);
                }
                Sound_SmallBang();
                StartSmallBang(pEnemy->x + Size, pEnemy->y + Size);
                End(pEnemy);
                AddScore(Points[pEnemy->type]);
                return true;    
            }
        }
    }
    return false;
}
