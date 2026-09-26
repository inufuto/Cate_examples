#include "Monster.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Debri.h"
#include "OneUp.h"
#include "Vram.h"

extern void _deb();

// constexpr byte SpriteColor = 7;

constexpr byte Monster_StatusMask = 0xc0;
constexpr byte Monster_Invalid = 0x00;
constexpr byte Monster_Standby = 0x40;
constexpr byte Monster_Start = 0x80;
constexpr byte Monster_Active = 0xc0;
constexpr byte Monster_PatternMask = 0x0f;

constexpr byte TimerValue = 8 * CoordRate;

struct Direction {
    sbyte dx, dy;
};
static const Direction[] Directions = {
    { -1, 0 },
    { 1, 0 },
    { 0, -1 },
    { 0, 1 },
};

Monster[MonsterSpriteCount] Monsters;


static bool CanMoveMonster(ptr<Monster> pMonster, sbyte dx, sbyte dy)
{
    if (!CanMove(pMonster, dx, dy)) return false;
    return (NextCell & Cell_Debri) == 0;
}

static void DecideDirection(ptr<Monster> pMonster)
{
    static byte[4] directionIndices;

    // if (Abs(Man.x, pMonster->x) > Abs(Man.y, pMonster->y)) {
    if (Man.y == pMonster->y) {
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
        if (Man.x < pMonster->x && pMonster->dx <= 0 || pMonster->dx < 0) {
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
            if (CanMoveMonster(pMonster, dx, dy)) {
                pMonster->dx = dx;
                pMonster->dy = dy;
                if (dx != 0) {
                    byte pattern = index << 1;
                    pMonster->status = (pMonster->status & ~Monster_PatternMask) | pattern;
                }
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
    byte status = pMonster->status;
    byte pattern = (status & Monster_PatternMask) + Pattern_Monster;
    byte seq = ((pMonster->x | pMonster->y) >> CoordShift) & 1;
    pattern += seq;
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
        pMonster->status = Monster_Active;
        pMonster->sprite = sprite;
        pMonster->dx = 0;
        pMonster->dy = 0;
        LocateMovable(pMonster, *pByte);
        pMonster->startX = pMonster->x;
        pMonster->startY = pMonster->y;
        DecideDirection(pMonster);
        Show(pMonster);
        ++sprite;
        ++pMonster;
        ++i;
        ++pByte;
    }
    while (i < MonsterSpriteCount) {
        pMonster->status = Monster_Invalid;
        pMonster->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++pMonster;
        ++i;
    }
}


void MoveMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        switch (pMonster->status & Monster_StatusMask) {
        case Monster_Active: 
            {
                if (((pMonster->x | pMonster->y) & CellCoordMask) == 0) {
                    // HitMan(pMonster->x, pMonster->y);
                    DecideDirection(pMonster);
                }
                pMonster->x += pMonster->dx;
                pMonster->y += pMonster->dy;
                Show(pMonster);
                HitToMan(pMonster);
            } 
            break;
        case Monster_Start:
            {
                byte count = pMonster->count;
                if (count == 0) {
                    pMonster->status = Monster_Active;
                    DecideDirection(pMonster);
                    Show(pMonster);
                }
                else {
                    if ((count & CoordMask) == 0) {
                        if (((count >> CoordShift) & 1) == 0) {
                            Show(pMonster);
                        }
                        else {
                            HideSprite(pMonster->sprite);
                        }
                    }
                    pMonster->count = count - 1;
                }
            }
            break;
        case Monster_Standby:
            {
                --pMonster->count;
                if (pMonster->count == 0) {
                    pMonster->count = TimerValue;
                    byte x = pMonster->startX;
                    byte y = pMonster->startY;
                    if (GetCell(x >> CellCoordShift, y >> CellCoordShift) == Cell_Space) {
                        pMonster->status = Monster_Start;
                        pMonster->x = x;
                        pMonster->y = y;
                    }
                }
            }
            break;
        }
    }
}


static void ShowDebri(ptr<Monster> pMonster)
{
    ShowSprite(pMonster, Pattern_Monster_Fall);
}


ptr<Monster> HitMonster(ptr<Movable> pFire)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Monster_StatusMask) == Monster_Active) {
            if (IsNear(pFire, pMonster)) {
                HideSprite(pMonster->sprite);
                StartDebri(pMonster->x, pMonster->y);
                pMonster->status = Monster_Standby;
                pMonster->count = TimerValue;
                StartOneUp();
                return pMonster;
            }
        }
    }
    return nullptr;
}
