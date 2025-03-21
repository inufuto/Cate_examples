#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Main.h"

extern void _deb();

constexpr byte SpriteColor1 = 13;
constexpr byte SpriteColor2 = 5;
constexpr byte PatternMask = 0x07;
constexpr byte Monster_Throgh = 0x20;

struct Direction {
    sbyte dx, dy;
};
static const Direction[] Directions = {
    { -1, 0 },
    { 1, 0 },
    { 0, -1 },
    { 0, 1 },
};


Monster[MaxMonsterCount] Monsters;


static void DecideDirection(ptr<Movable> pMonster)
{
    static byte[4] directionIndices;

    if (Abs(Man.x, pMonster->x) > Abs(Man.y, pMonster->y)) {
        byte verticalDirectionIndex;
        if (Man.x < pMonster->x) {
            if (pMonster->dx <= 0) {
                directionIndices[0] = Direction_Left;
                directionIndices[3] = Direction_Right;
                verticalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Right;
                directionIndices[3] = Direction_Left;
                verticalDirectionIndex = 0;
            }
        }
        else {
            if (pMonster->dx >= 0) {
                directionIndices[0] = Direction_Right;
                directionIndices[3] = Direction_Left;
                verticalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Left;
                directionIndices[3] = Direction_Right;
                verticalDirectionIndex = 0;
            }
        }
        if (Man.y < pMonster->y && pMonster->dy <= 0 || pMonster->dy < 0) {
            directionIndices[verticalDirectionIndex] = Direction_Up;
            ++verticalDirectionIndex;
            directionIndices[verticalDirectionIndex] = Direction_Down;
        }
        else {
            directionIndices[verticalDirectionIndex] = Direction_Down;
            ++verticalDirectionIndex;
            directionIndices[verticalDirectionIndex] = Direction_Up;
        }
    }
    else {
        byte horizontalDirectionIndex;
        if (Man.y < pMonster->y) {
            if (pMonster->dy <= 0) {
                directionIndices[0] = Direction_Up;
                directionIndices[3] = Direction_Down;
                horizontalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Down;
                directionIndices[3] = Direction_Up;
                horizontalDirectionIndex = 0;
            }
        }
        else {
            if (pMonster->dy >= 0) {
                directionIndices[0] = Direction_Down;
                directionIndices[3] = Direction_Up;
                horizontalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Up;
                directionIndices[3] = Direction_Down;
                horizontalDirectionIndex = 0;
            }
        }
        if (Man.x < pMonster->y && pMonster->dx <= 0 || pMonster->dx < 0) {
            directionIndices[horizontalDirectionIndex] = Direction_Left;
            ++horizontalDirectionIndex;
            directionIndices[horizontalDirectionIndex] = Direction_Right;
        }
        else {
            directionIndices[horizontalDirectionIndex] = Direction_Right;
            ++horizontalDirectionIndex;
            directionIndices[horizontalDirectionIndex] = Direction_Left;
        }
    }
    {
        bool throughable = (pMonster->status & Monster_Throgh) != 0;
        byte i = 0;
        ptr<byte> pDirectionIndex;
        for (pDirectionIndex: directionIndices) {
            byte index = *pDirectionIndex;
            ptr<Direction> pDirection = Directions + index;
            sbyte dx = pDirection->dx;
            sbyte dy = pDirection->dy;
            bool can = CanMove(pMonster, dx, dy);
            if (can) {
                if (throughable && i == 0) {
                    pMonster->status &= ~Monster_Throgh;
                }
            }
            else if (throughable) {
                can = InRange(pMonster, dx, dy);
            }
            if (can) {
                pMonster->dx = dx;
                pMonster->dy = dy;
                pMonster->status = (pMonster->status & ~PatternMask) | index;
                return;
            }
            ++i;
        }
    }
    pMonster->dx = 0;
    pMonster->dy = 0;
}

static void Show(ptr<Movable> pMonster)
{
    byte status = pMonster->status;
    byte pattern = status & PatternMask;
    if ((status & Monster_Throgh) != 0) {
        pattern += Pattern_MonsterRev;
    }
    else {
        byte seq = ((pMonster->x + pMonster->y) >> CoordShift) & 1;
        pattern = (pattern << 1) + seq + Pattern_Monster;
    }
    ShowSprite(pMonster, pattern);
}


void InitMonsters()
{
    ptr<Monster> pMonster = Monsters;
    ptr<byte> pByte = pStage->pEnemies;
    byte count = pStage->enemyCount;
    byte i = 0;
    byte sprite = Sprite_Monster;
    while (i < count) {
        pMonster->status = Movable_Live;
        pMonster->sprite = sprite;
        pMonster->dx = 0;
        pMonster->dy = 0;
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


void MoveMonsters()
{
    static byte clock;
    ++clock;

    ptr<Movable> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->status & Movable_Live) != 0) {
            if ((pMonster->status & Movable_Fall) == 0) {
                if (((pMonster->x | pMonster->y) & CellCoordMask) == 0) {
                    if ((pMonster->status & Movable_Fall) == 0) {
                        if ((Rnd() << 1) <= CurrentStage) {
                            pMonster->status |= Monster_Throgh;
                        }
                        DecideDirection(pMonster);
                    }
                }
            }
            if ((clock & 1) == 0 || (pMonster->status & Monster_Throgh) == 0) {
                MoveMovable(pMonster);
            }
            if (IsNear(pMonster, &Man)) {
                Man.status &= ~Movable_Live;
            }
            if (
                ((pMonster->x | pMonster->y) & CellCoordMask) == 0 &&
                (pMonster->status & Monster_Throgh) == 0
            ) {
                if (FallMovable(pMonster)) {
                    pMonster->dy = 1;
                    pMonster->dx = 0;
                }
            }
            Show(pMonster);
        }
    }
}


bool HitMonster(ptr<Movable> pMovable)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->status & Movable_Live) == 0) continue;
        if (IsNear(pMovable, pMonster)) {
            pMonster->status &= ~Movable_Live;
            HideSprite(pMonster->sprite);
            return true;
        }
    }
    return false;
}
