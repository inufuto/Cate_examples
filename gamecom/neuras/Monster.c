#include "Monster.h"
#include "Sprite.h"
#include "Chars.h"
#include "Solver.h"
// #include "Sound.h"

constexpr byte Sprite = 0;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

static const MonsterDirection[] Directions = {
    { -1, 0, Pattern_Monster_Left },
    { 1, 0, Pattern_Monster_Right },
    { 0, -1, Pattern_Monster_Up },
    { 0, 1, Pattern_Monster_Down }
};

static const sbyte[4] RotationPatterns = {
    Pattern_Monster_Left,
    Pattern_Monster_Down,
    Pattern_Monster_Right,
    Pattern_Monster_Up
};

Monster[MonsterCount] Monsters;

constexpr sbyte SpeedDenominator = 7;
constexpr sbyte SpeedNumerator = 3;
sbyte SpeedValue;

static byte FromPosition(byte a)
{
    return (a + a + a + 1) << 3;
}

static byte Abs(byte a, byte b)
{
    return a >= b ? a - b : b - a;
}

static void DecideDirection(ptr<Monster> pMonster)
{
    ptr<MonsterDirection> pDirection, pNewDirection;
    ptr<MonsterDirection>[4] directions;
    ptr< ptr<MonsterDirection> > ppDirection;

    pDirection = pMonster->pDirection;

    if (Abs(SolverX, pMonster->x) > Abs(SolverY, pMonster->y)) {
        byte verticalDirectionIndex;
        if (SolverX < pMonster->x) {
            if (pDirection->dx <= 0) {
                directions[0] = Directions + Direction_Left;
                directions[3] = Directions + Direction_Right;
                verticalDirectionIndex = 1;
            }
            else {
                directions[2] = Directions + Direction_Right;
                directions[3] = Directions + Direction_Left;
                verticalDirectionIndex = 0;
            }
        }
        else {
            if (pDirection->dx >= 0) {
                directions[0] = Directions + Direction_Right;
                directions[3] = Directions + Direction_Left;
                verticalDirectionIndex = 1;
            }
            else {
                directions[2] = Directions + Direction_Left;
                directions[3] = Directions + Direction_Right;
                verticalDirectionIndex = 0;
            }
        }
        if (
            SolverY < pMonster->y && pDirection->dy <= 0 ||
            pDirection->dy < 0
        ) {
            directions[verticalDirectionIndex] = Directions + Direction_Up;
            ++verticalDirectionIndex;
            directions[verticalDirectionIndex] = Directions + Direction_Down;
        }
        else {
            directions[verticalDirectionIndex] = Directions + Direction_Down;
            ++verticalDirectionIndex;
            directions[verticalDirectionIndex] = Directions + Direction_Up;
        }
    }
    else {
        byte horizontalDirectionIndex;
        if (SolverY < pMonster->y) {
            if (pDirection->dy <= 0) {
                directions[0] = Directions + Direction_Up;
                directions[3] = Directions + Direction_Down;
                horizontalDirectionIndex = 1;
            }
            else {
                directions[2] = Directions + Direction_Down;
                directions[3] = Directions + Direction_Up;
                horizontalDirectionIndex = 0;
            }
        }
        else {
            if (pDirection->dy >= 0) {
                directions[0] = Directions + Direction_Down;
                directions[3] = Directions + Direction_Up;
                horizontalDirectionIndex = 1;
            }
            else {
                directions[2] = Directions + Direction_Up;
                directions[3] = Directions + Direction_Down;
                horizontalDirectionIndex = 0;
            }
        }
        if (
            SolverX < pMonster->y && pDirection->dx <= 0 ||
            pDirection->dx < 0 
        ) {
            directions[horizontalDirectionIndex] = Directions + Direction_Left;
            ++horizontalDirectionIndex;
            directions[horizontalDirectionIndex] = Directions + Direction_Right;
        }
        else {
            directions[horizontalDirectionIndex] = Directions + Direction_Right;
            ++horizontalDirectionIndex;
            directions[horizontalDirectionIndex] = Directions + Direction_Left;
        }
    }

    for (ppDirection: directions) {
        byte newX, newY;
        
        pNewDirection = *ppDirection;
        newX = pMonster->x + pNewDirection->dx;
        newY = pMonster->y + pNewDirection->dy;
        if (TestMap2(newX, newY)) {
            pMonster->pDirection = pNewDirection;
            return;
        }
    }
}

void InitMonsters(ptr<byte> pPosition, byte count) 
{
    ptr<Monster> pMonster;
    byte i, sprite;

    sprite = Sprite;
    pMonster = Monsters;
    i = 0;
    while (count != 0 && i < MonsterCount) {
        pMonster->status = Monster_Status_Normal;
        pMonster->x = FromPosition(*pPosition >> 4);
        pMonster->y = FromPosition(*pPosition & 0x0f);
        pMonster->pDirection = nullptr;
        DecideDirection(pMonster);
        ShowSprite(sprite, pMonster->x - 8, pMonster->y - 8, Pattern_Monster_Left);
        ++pMonster;
        ++pPosition;
        ++sprite;
        --count;
        ++i;
    }
    while (i < MonsterCount) {
        pMonster->status = Monster_Status_None;
        HideSprite(sprite);
        ++sprite;
        ++pMonster;
        ++i;
    }
    SpeedValue = 0;
}

void MoveMonsters() 
{
    ptr<Monster> pMonster;
    byte sprite;

    SpeedValue += SpeedNumerator;
    if (SpeedValue <0) return;
    SpeedValue -= SpeedDenominator;

    sprite = Sprite;
    for (pMonster: Monsters) {
        if (pMonster->status == Monster_Status_Normal) {
            byte newX, newY, seq;
            ptr<MonsterDirection> pDirection;

            if (
                pMonster->pDirection == nullptr ||
                ((pMonster->x + pMonster->y) & 7) == 0
            ) {
                DecideDirection(pMonster);
            }

            pDirection = pMonster->pDirection;
            newX = pMonster->x + pDirection->dx;
            newY = pMonster->y + pDirection->dy;

            if (TestMap2(newX, newY)) {
                pMonster->x = newX; 
                pMonster->y = newY;
                seq = ((newX + newY + 4) >> 3) & 1;
                ShowSprite(sprite, newX - 8, newY - 8, pDirection->pattern + seq);
                if (newX - SolverX + 12 < 24 && newY - SolverY + 12 < 24) {
                    SolverStatus = Solver_Status_Die;
                }
            }
        }
        else if (pMonster->status == Monster_Status_Stop) {
            sbyte pattern;
            pattern = RotationPatterns[(pMonster->stopCount >> 3) & 3];
            ShowSprite(sprite, pMonster->x - 8, pMonster->y - 8, pattern);
            --pMonster->stopCount;
            if (pMonster->stopCount == 0) {
               pMonster->status = Monster_Status_Normal;
               DecideDirection(pMonster);
            }
        }
        ++sprite;
    }
}

bool Monster_TestHit(byte x, byte y)
{
    ptr<Monster> pMonster;
    bool hit;

    hit = false;
    for (pMonster: Monsters) {
        byte xDiff, yDiff;

        if (pMonster->status != Monster_Status_Normal) continue;
        xDiff = pMonster->x - x;
        yDiff = pMonster->y - y;
        if (xDiff + 8 < 16 && yDiff + 8 < 16) {
            byte newX, newY;
            pMonster->status = Monster_Status_Stop;
            pMonster->stopCount = 0;
            pMonster->x = (pMonster->x + 4) & 0xf8;
            pMonster->y = (pMonster->y + 4) & 0xf8;
            hit = true;
            // repeat (3) Sound_Get();
        }
    }
                            // *(ptr<word>)0xdf00 = (word)pMonster;

    return hit;
}