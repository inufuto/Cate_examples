#include "Robo.h"
#include "Sprite.h"
#include "Main.h"
#include "Fort.h"
#include "Stage.h"
#include "Direction.h"
#include "Bullet.h"
#include "Bang.h"
#include "Sound.h"
#include "Chars.h"

static const byte[] Numbers = { 11, 8, 9, 4, 4, 12, 0, 12, 13, 11, 0, 6, 13, 12, 5, 15, };
static byte RndIndex;

byte Rnd() 
{
    byte r;
    r = Numbers[RndIndex];
    ++RndIndex;
    if (RndIndex >= 16) {
        RndIndex = 0;
    }
    return r;
}


constexpr byte Count = Sprite_MyBullet - Sprite_EnemyRobo;
// constexpr byte Count = 1;

Robo[Count] EnemyRobos;
ptr<Robo> pHitEnemyRobo;
static byte startCount;
static byte startInterval;

void InitEnemyRobos()
{
    ptr<Robo> pRobo;
    for (pRobo: EnemyRobos) {
        pRobo->status = 0;
    }
    {
        constexpr byte MaxInterval = 0x7f;
        constexpr byte MaxStage = 0x20;
        constexpr byte Step = MaxInterval / MaxStage;
        byte i;
        startInterval = MaxInterval;
        i = 0;
        while (i < MaxStage && i < CurrentStage) {
            startInterval -= Step;
            ++i;
        }
    }
    startCount = 0;
}


static void Draw(ptr<Robo> pRobo)
{
    if ((pRobo->status & Robo_Status_Mask) != Robo_Status_None) {
        ShowSprite(pRobo->sprite, pRobo->x, pRobo->y, 
            Char_EnemyRobo + ((pRobo->status & Robo_Pattern_Mask) << 2));
    }
    else {
        HideSprite(pRobo->sprite);
    }
}

static byte Abs(byte a, byte b)
{
    if (a < b) {
        return b - a;
    }
    else {
        return a - b;
    }
}

byte  DecideDirection(ptr<Robo> pRobo)
{
    byte[4] directions;
    byte x, y, targetX, targetY;
    byte target;
    
    x = pRobo->x;
    y = pRobo->y;
    target = pRobo->status & Robo_Target_Mask;
    if (target == 0) {
        targetX = MyRobo.x;
        targetY = MyRobo.y;
    }
    else {
        targetX = MyFort.x;
        targetY = MyFort.y;
    }
    aaa:
    if (Abs(targetX, x) > Abs(targetY, y)) {
        byte verticalDirectionIndex;
        if (targetX < x) {
            if (pRobo->dx <= 0) {
                directions[0] = Direction_Left;
                directions[3] = Direction_Right;
                verticalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Right;
                directions[3] = Direction_Left;
                verticalDirectionIndex = 0;
            }
        }
        else {
            if (pRobo->dx >= 0) {
                directions[0] = Direction_Right;
                directions[3] = Direction_Left;
                verticalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Left;
                directions[3] = Direction_Right;
                verticalDirectionIndex = 0;
            }
        }
        if (targetY < y && pRobo->dy <= 0 || pRobo->dy < 0) {
            directions[verticalDirectionIndex] = Direction_Up;
            ++verticalDirectionIndex;
            directions[verticalDirectionIndex] = Direction_Down;
        }
        else {
            directions[verticalDirectionIndex] = Direction_Down;
            ++verticalDirectionIndex;
            directions[verticalDirectionIndex] = Direction_Up;
        }
    }
    else {
        byte horizontalDirectionIndex;
        if (targetY < y) {
            if (pRobo->dy <= 0) {
                directions[0] = Direction_Up;
                directions[3] = Direction_Down;
                horizontalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Down;
                directions[3] = Direction_Up;
                horizontalDirectionIndex = 0;
            }
        }
        else {
            if (pRobo->dy >= 0) {
                directions[0] = Direction_Down;
                directions[3] = Direction_Up;
                horizontalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Up;
                directions[3] = Direction_Down;
                horizontalDirectionIndex = 0;
            }
        }
        if (targetX < y && pRobo->dx <= 0 || pRobo->dx < 0) {
            directions[horizontalDirectionIndex] = Direction_Left;
            ++horizontalDirectionIndex;
            directions[horizontalDirectionIndex] = Direction_Right;
        }
        else {
            directions[horizontalDirectionIndex] = Direction_Right;
            ++horizontalDirectionIndex;
            directions[horizontalDirectionIndex] = Direction_Left;
        }
    }    
    {
        ptr<byte> pDirection;
        for (pDirection: directions) {
            byte newDirection, newX, newY, wall;
            ptr<sbyte> pNewDirection;

            newDirection = *pDirection;
            pNewDirection =  DirectionPtr(newDirection);
            newX = x + *pNewDirection;
            ++pNewDirection;
            newY = y + *pNewDirection;
            wall = WallAroundRobo(pRobo, newX, newY);
            if (
                wall == Wall_None || 
                (wall >= Wall_MyRobo && wall < Wall_EnemyRobo) ||
                (wall < Wall_Hard && (pRobo->count & 0x08) == 0)
            ) {
                SetRoboDirection(pRobo, newDirection);
                return wall;
            }
        }
    }
    return Wall_Hard;
}

bool StartEnemyRobo()
{
    byte sprite;
    ptr<Robo> pRobo;

    ++startCount;
    if (startCount < startInterval) return false;
    startCount = 0;

    sprite = Sprite_EnemyRobo;
    for (pRobo: EnemyRobos) {
        if ((pRobo->status & Robo_Status_Mask) == Robo_Status_None) {
            if (StartRobo(pRobo, EnemyFort.x, EnemyFort.y)) {
                pRobo->sprite = sprite;
                pRobo->status = Robo_Status_Live;
                if ((Rnd() & 1) != 0) {
                    pRobo->status |= Robo_Target_Mask;
                }
                pRobo->count = 0;
                SetRoboDirection(pRobo, 0);
                DecideDirection(pRobo);
                Draw(pRobo);
                return true;
            }
        }
        ++sprite;
    }
    return false;
}


void MoveEnemyRobos()
{
    ptr<Robo> pRobo;

    for (pRobo: EnemyRobos) {
        byte status;
        status = pRobo->status & Robo_Status_Mask;
        if (status != Robo_Status_None) {
            if ((pRobo->step & StepMask) == 0) {
                bool fire;
                byte wall;
                fire = false;
                wall = DecideDirection(pRobo);
                if (wall != Wall_None) {
                    pRobo->status &= ~Robo_CanMove_Mask;
                    if (wall < Wall_Hard || wall == Wall_MyRobo || wall == Wall_MyFort) {
                        if ((pRobo->count & 7) == 0) {
                            fire = true;
                        }
                    }
                }
                else {
                    pRobo->status |= Robo_CanMove_Mask;
                }
                if (fire || ((pRobo->count & 3) == 0 && Rnd() <= CurrentStage)) {
                    Fire(pRobo, false);
                }
                ++pRobo->count;
                if (pRobo->count == 0) {
                    pRobo->status ^= Robo_Target_Mask;
                }
            }
            MoveRobo(pRobo);
            Draw(pRobo);
        }
    }
}


bool HitEnemyRoboR(ptr<Robo> p, byte x, byte y)
{
    ptr<Robo> pRobo;

    for (pRobo: EnemyRobos) {
        if (pRobo != p && (pRobo->status & Robo_Status_Mask) != Robo_Status_None) {
            if (HitRoboR(pRobo, x, y)) {
                return true;
            }
        }
    }
    return false;
}


bool HitEnemyRoboB(ptr<Bullet> pBullet)
{
    constexpr byte Range = (StepMask + 1) / 2;
    ptr<Robo> pRobo;

    for (pRobo: EnemyRobos) {
        byte side;
        side = pBullet->status & Bullet_Side_Mask;
        if (side != Bullet_Side_My && pBullet->step < Range) continue;
        if (HitRoboB(pRobo, pBullet)) {
            if (
                side == Bullet_Side_My &&
                (pRobo->status & Robo_Status_Mask) == Robo_Status_Live
            ) {
                StartBang(pRobo->x, pRobo->y, false);
                // Sound_SmallBang();
                Sound_Hit();
                pRobo->status &= ~Robo_Status_Mask;
                Draw(pRobo);
                AddScore(10);
            }
            return true;
        }
    }
    return false;
}