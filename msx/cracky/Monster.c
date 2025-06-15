#include "Monster.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"

constexpr byte Color = 13;
constexpr byte PatternMask = 0x07;
constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 2;
constexpr byte Direction_Up = 4;
constexpr byte Direction_Down = 6;

static const sbyte[] DirectionTable = {
    -1, 0,
    1, 0,
    0, -1,
    0, 1,
};

byte MonsterCount;
Movable[MaxMonsterCount] Monsters;

extern void _deb();

static void DecideDirection(ptr<Movable> pMonster)
{
    byte[4] directions;
    byte target;

    if (Abs(Man.x, pMonster->x) > Abs(Man.y, pMonster->y)) {
        byte verticalDirectionIndex;
        if (Man.x < pMonster->x) {
            if (pMonster->dx <= 0) {
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
            if (pMonster->dx >= 0) {
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
        if (Man.y < pMonster->y && pMonster->dy <= 0 || pMonster->dy < 0) {
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
        if (Man.y < pMonster->y) {
            if (pMonster->dy <= 0) {
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
            if (pMonster->dy >= 0) {
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
        if (Man.x < pMonster->y && pMonster->dx <= 0 || pMonster->dx < 0) {
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
        bool throughable;
        ptr<byte> pDirection;
        for (pDirection: directions) {
            byte direction, newX, newY;
            byte count;
            ptr<sbyte> pVector;
            sbyte dx, dy;
            direction = *pDirection;
            pVector = DirectionTable + direction;
            dx = *pVector; ++pVector;
            dy = *pVector;
            if (CanMove(pMonster, dx, dy)) {
                byte pattern;
                pMonster->dx = dx;
                pMonster->dy = dy;
                pattern = direction;
                pMonster->status = (pMonster->status & ~PatternMask) | pattern;
                return;
            }
        }
    }
    pMonster->dx = 0;
    pMonster->dy = 0;
}


static void Show(ptr<Movable> pMonster)
{
    byte pattern;
    byte seq;
    pattern = (pMonster->status & PatternMask) + Pattern_Monster;
    seq = ((pMonster->x + pMonster->y) >> CoordShift) & 1;
    pattern += seq;
    ShowSprite(pMonster, pattern, Color);
}


void InitMonsters()
{
    ptr<Movable> pMonster;
    ptr<byte> pByte;
    byte i, sprite;
    pMonster = Monsters;
    pByte = pStage->pEnemies;
    MonsterCount = pStage->enemyCount;
    i = 0;
    sprite = Sprite_Monster;
    while (i < MonsterCount) {
        pMonster->status = Movable_Live;
        pMonster->sprite = sprite;
        LocateMovable(pMonster, *pByte);
        DecideDirection(pMonster);
        Show(pMonster);
        ++sprite;
        ++pMonster;
        ++i;
        ++pByte;
    }
    while (i < MaxMonsterCount) {
        pMonster->status = 0;
        pMonster->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++pMonster;
        ++i;
    }
}


void FallMonsters()
{
    ptr<Movable> pMonster;
    for (pMonster : Monsters) {
        byte status;
        if ((pMonster->status & (Movable_Live | Movable_Fall)) == (Movable_Live | Movable_Fall)) {
            if (
                (pMonster->x & CoordMask) == 0 &&
                (pMonster->y & CoordMask) == 0
            ) {
                if (FallMovable(pMonster)) { //  && CanMove(pMonster, pMonster->dx, 1)
                    pMonster->dy = 1;
                    pMonster->dx = 0;
                }
                MoveMovable(pMonster);
                Show(pMonster);
            }
        }
    }
}

void MoveMonsters()
{
    ptr<Movable> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->status & Movable_Live) != 0) {
            if (
                (pMonster->x & CoordMask) == 0 &&
                (pMonster->y & CoordMask) == 0
            ) {
                if ((pMonster->status & Movable_Fall) == 0) {
                    DecideDirection(pMonster);
                }
            }
            MoveMovable(pMonster);
            Show(pMonster);
            if (IsNear(pMonster, &Man)) {
                Man.status &= ~Movable_Live;
            }
            if (
                (pMonster->x & CoordMask) == 0 &&
                (pMonster->y & CoordMask) == 0
            ) {
                FallMovable(pMonster);
            }
        }
    }
}
