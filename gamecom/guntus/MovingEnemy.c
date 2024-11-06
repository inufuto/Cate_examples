#include "MovingEnemy.h"
#include "Sprite.h"
#include "Chars.h"
#include "Direction.h"
#include "Math.h"
#include "Coord.h"
#include "EnemyRow.h"
#include "Status.h"
#include "EnemyBullet.h"
#include "Sound.h"
#include "Bang.h"
#include "Team.h"
#include "Enemy.h"
#include "Fighter.h"
#include "VVram.h"
#include "Item.h"

extern void _deb();

constexpr byte FireMask = CoordRate * 2 - 1;
constexpr byte TurnMask = CoordRate * 2 - 1;
constexpr byte LongMask = CoordRate * 4 - 1;

constexpr byte Type_Crash = 0;
constexpr byte Type_Smart = 1;
constexpr byte Type_Insistent = 2;

constexpr byte RangeX = (VVramWidth - 2) * CoordRate;
constexpr byte RangeY = (VVramHeight - 2) * CoordRate;

MovingEnemy[MaxEnemyCount] MovingEnemies;
byte FreeEnemyCount;
static byte localClock;
static const byte[] Points = { 2, 4, 10 };

void InitMovingEnemies()
{
    ptr<MovingEnemy> pEnemy;
    byte sprite;
    sprite = Sprite_Enemy;
    for (pEnemy : MovingEnemies) {
        pEnemy->status = MovingEnemy_None;
        pEnemy->sprite = sprite;
        ++sprite;
    }
    FreeEnemyCount = MaxEnemyCount;
    localClock = 0;
}


ptr<MovingEnemy> StartMovingEnemy(byte status, byte type)
{
    ptr<MovingEnemy> pEnemy;
    for (pEnemy : MovingEnemies) {
        if (pEnemy->status == MovingEnemy_None) {
            pEnemy->status = status;
            pEnemy->type = type;
            pEnemy->bulletCount = CurrentStage + 1;
            --FreeEnemyCount;
            return pEnemy;
        }
    }
    return nullptr;
}


void ShowMovingEnemy(ptr<MovingEnemy> pEnemy)
{
    byte type, pattern;
    type = pEnemy->type;
    pattern = Pattern_Enemy + (type << 3) | pEnemy->direction;
    ShowSprite(pEnemy->sprite, pEnemy->x, pEnemy->y, pattern);
}


void SetMovingEnemyDirection(ptr<MovingEnemy> pEnemy, byte direction)
{
    ptr<Direction> pDirection;
    pDirection = Directions + direction;
    pEnemy->dx = pDirection->dx;
    pEnemy->dy = pDirection->dy;
    pEnemy->direction = direction;
}

static void End(ptr<MovingEnemy> pEnemy)
{
    pEnemy->status = MovingEnemy_None;
    HideSprite(pEnemy->sprite);
    ++FreeEnemyCount;
}


static void Fire(ptr<MovingEnemy> pEnemy)
{
    if (
        (localClock & FireMask) == 0 &&
        pEnemy->bulletCount > 0
    ) {
        byte threshold;
        threshold = CurrentStage + 2;
        if (pEnemy->status < MovingEnemy_Attack) {
            threshold >>= 1;
        }
        if (Rnd() < threshold) {
            if (StartEnemyBullet(pEnemy->x, pEnemy->y)) {
                --pEnemy->bulletCount;
            }
        }
    }
}


static bool Turn(ptr<MovingEnemy> pEnemy, byte direction)
{
    byte diff;
    if (direction == pEnemy->direction) return true;
    
    diff = (direction - pEnemy->direction) & 7;
    if (diff <= 4) {
        direction = (pEnemy->direction + 1) & 7;
    }
    else {
        direction = (pEnemy->direction - 1) & 7;
    }
    SetMovingEnemyDirection(pEnemy, direction);
}


static void DecideDirection(ptr<MovingEnemy> pEnemy)
{
    sbyte dx, dy;
    byte direction;
    switch (pEnemy->type) {
    case Type_Crash:
        {
            dx = Sign(pEnemy->x, FighterX);
            dy = 1;
        }
        break;
    case Type_Smart: 
        {
            dx = Sign(pEnemy->x, FighterX);
            dy = Sign(pEnemy->y, FighterY);
        }
        break;
    case Type_Insistent:
        if ((localClock & LongMask) != 0) {
            byte x, y;
            x = (Rnd() & 0x0f) << (1 + CoordShift);
            y = ((Rnd() & 0x0f) + 4) << CoordShift;
            dy = Sign(pEnemy->y, y);
            dx = Sign(pEnemy->x, x);
        }
        break;
    }
    direction = ToDirection(dx, dy);
    if (!Turn(pEnemy, direction)) {
        SetMovingEnemyDirection(pEnemy, direction);
    }
}


static void Destroy(ptr<MovingEnemy> pEnemy)
{
    if (pEnemy->status < MovingEnemy_Align) {
        RemoveMember(pEnemy);
    }
    // Sound_SmallBang();
    Sound_Hit();
    StartBang(pEnemy->x + CoordRate, pEnemy->y + CoordRate, false);
    End(pEnemy);
    --EnemyCount;
    AddScore(Points[pEnemy->type]);
}


static bool Move(ptr<MovingEnemy> pEnemy)
{
    byte newX, newY;
    bool inRange;
    inRange = true;
    newX = pEnemy->x + pEnemy->dx;
    if (newX >= RangeX + 1) {
        if (pEnemy->x < CoordRate * 2) {
            newX = 0;
        }
        else {
            newX = RangeX;
        }
        inRange = false;
    }
    pEnemy->x = newX;
    newY = pEnemy->y += pEnemy->dy;
    if (newY >= RangeY + 1) {
        if (pEnemy->y < CoordRate * 2) {
            newY = 0;
        }
        else {
            newY = RangeY;
        }
        inRange = false;
    }
    pEnemy->y = newY;
    ShowMovingEnemy(pEnemy);
    if (HitEnemyFighter(pEnemy->x, pEnemy->y)) {
        Destroy(pEnemy);
        inRange = true;
    }
    return inRange;
}


void MoveMovingEnemies()
{
    ptr<MovingEnemy> pEnemy;
    for (pEnemy : MovingEnemies) {
        switch (pEnemy->status) {
        case MovingEnemy_Align:
            align:
            if ((localClock & CoordMask) == 0) {
                byte targetX, targetY;
                targetX = FixedEnemyX(pEnemy->target);
                targetY = FixedEnemyY(pEnemy->target);
                if (
                    Abs(pEnemy->x, targetX) < CoordRate &&
                    Abs(pEnemy->y, targetY) < CoordRate 
                ) {
                    pEnemy->status = MovingEnemy_Turn;
                    goto turn;
                }
                pEnemy->dx = Sign(pEnemy->x, targetX);
                pEnemy->dy = Sign(pEnemy->y, targetY);
                pEnemy->direction = ToDirection(pEnemy->dx, pEnemy->dy);
            }
            Move(pEnemy);
            break;
        case MovingEnemy_Sally:
            Fire(pEnemy);
            Move(pEnemy);
            break;
        case MovingEnemy_Turn:
            if ((localClock & CoordMask) == 0) {
                turn:
                if (Turn(pEnemy, Direction_Up)) {
                    AddEnemyRowMember(pEnemy->target, pEnemy->type);
                    End(pEnemy);
                    break;
                }
                {
                    byte targetX, targetY;
                    targetX = FixedEnemyX(pEnemy->target);
                    pEnemy->dx = Sign(pEnemy->x, targetX);
                    targetY = FixedEnemyY(pEnemy->target);
                    pEnemy->dy = Sign(pEnemy->y, targetY);
                }
            }
            Move(pEnemy);
            break;
        case MovingEnemy_Attack:
            if ((localClock & 1) == 0) {
                if ((localClock & TurnMask) == 0) {
                    DecideDirection(pEnemy);
                }
                Fire(pEnemy);
                if (pEnemy->bulletCount == 0) {
                    pEnemy->status = MovingEnemy_Return;
                }
                if (!Move(pEnemy)) {
                    pEnemy->status = MovingEnemy_Return;
                }
            }
            break;
        case MovingEnemy_Return:
            if ((localClock & 1) == 0) goto align;
            break;
        }
    }
    ++localClock;
}


bool HitBulletMovingEnemy(byte x, byte y)
{
    ptr<MovingEnemy> pEnemy;
    for (pEnemy : MovingEnemies) {
        if (pEnemy->status >= MovingEnemy_Sally) {
            if (HitBulletEnemy(x, y, pEnemy->x, pEnemy->y)) {
                if (
                    pEnemy->type == 2 &&
                    pEnemy->status == MovingEnemy_Attack &&
                    y < VVramHeight / 2 * CoordRate &&
                    RemainCount < 10 && 
                    Rnd() < 6
                ) {
                    StartItem(pEnemy->x, pEnemy->y);
                }
                Destroy(pEnemy);
                return true;    
            }
        }
    }
    return false;
}
