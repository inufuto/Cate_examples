#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Main.h"
#include "Sound.h"
#include "Point.h"

extern void _deb();

constexpr byte Monster_Throgh = 0x20;
constexpr byte CellCoordMask = 2 * CoordRate - 1;

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

static void DecideDirection(ptr<Monster> pMonster)
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
        byte i = 0;
        ptr<byte> pDirectionIndex;
        for (pDirectionIndex: directionIndices) {
            byte index = *pDirectionIndex;
            ptr<Direction> pDirection = Directions + index;
            sbyte dx = pDirection->dx;
            sbyte dy = pDirection->dy;
            bool can = CanMove(pMonster, dx, dy);
            if (can) {
                if (i == 0) {
                    pMonster->status &= ~Monster_Throgh;
                }
            }
            else if ((pMonster->status & Monster_Throgh) != 0) {
                can = NextCell != Cell_Bomb && InRange(pMonster, dx, dy);
            }
            if (can) {
                pMonster->dx = dx;
                pMonster->dy = dy;
                byte pattern = index << 1;
                pMonster->status = (pMonster->status & ~Actor_PatternMask) | pattern;
                return;
            }
            ++i;
        }
    }
    pMonster->dx = 0;
    pMonster->dy = 0;
}

static void Show(ptr<Monster> pMonster)
{
    constexpr byte SpriteColor1 = 13;
    constexpr byte SpriteColor2 = 5;

    byte status = pMonster->status;
    byte pattern = (status & Actor_PatternMask) + Pattern_Monster;
    byte seq = ((pMonster->x + pMonster->y) >> CoordShift) & 1;
    pattern += seq;
    byte color = (status & Monster_Throgh) != 0 ? SpriteColor2 : SpriteColor1;
    ShowSprite(pMonster, pattern, color);
}


void InitMonsters()
{
    ptr<Monster> pMonster = Monsters;
    ptr<byte> pByte = pStage->pMonsters;
    byte count = pStage->monsterCount;
    byte i = 0;
    byte sprite = Sprite_Monster;
    while (i < count) {
        pMonster->status = Movable_Live;
        pMonster->sprite = sprite;
        pMonster->dx = 0;
        pMonster->dy = 0;
        LocateActor(pMonster, *pByte);
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

    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0) {
            if ((status & Actor_Fall) == 0) {
                if (((pMonster->x | pMonster->y) & CellCoordMask) == 0) {
                    if ((status & Actor_Fall) == 0) {
                        if ((Rnd() << 2) <= CurrentStage) {
                            status |= Monster_Throgh;
                            pMonster->status = status;
                        }
                        DecideDirection(pMonster);
                    }
                }
            }
            if ((clock & 1) == 0 || (status & Monster_Throgh) == 0) {
                MoveActor(pMonster);
            }
            if (IsNear(pMonster, &Man)) {
                Man.status &= ~Movable_Live;
            }
            if (
                ((pMonster->x | pMonster->y) & CellCoordMask) == 0 &&
                (status & Monster_Throgh) == 0
            ) {
                if (FallActor(pMonster)) {
                    pMonster->dy = 1;
                    pMonster->dx = 0;
                }
            }
            Show(pMonster);
        }
    }
}


void HitMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0) {
            byte row = (pMonster->y + CoordRate) >> (RowShift + CoordShift);
            if ((row & 1) == 0) {
                byte floor = row >> 1;
                if (floor == ScrollingFloor) {
                    byte x = pMonster->x >> CoordShift;
                    byte column = x >> ColumnShift;
                    if ((x & 1) == 0) {
                        if (GetCell(column, row) == Cell_Bomb) {
                            hit:
                            Sound_Bang();
                            pMonster->status &= ~Movable_Live;
                            EraseBomb(column, floor);
                            HideSprite(pMonster->sprite);
                            StartPoint(pMonster->x, pMonster->y, 2);
                            AddScore(40);
                        }
                    }
                    else {
                        if (GetCell(column, row) == Cell_Bomb) goto hit;
                        ++column;
                        if (GetCell(column, row) == Cell_Bomb) goto hit;
                    }                
                }
            }
        }
    }
}