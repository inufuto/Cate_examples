#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Enemy.h"
#include "Sound.h"
#include "Point.h"
#include "OneUp.h"

extern void _deb();

constexpr byte Monster_Available = 0x20; 
constexpr byte Monster_Start = 0x40;
constexpr byte Monster_Live = 0x80;

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
static ptr<Monster> pNextMonster;
static byte NextIndex;
static byte Clock;

static void Next()
{
    ++pNextMonster;
    ++NextIndex;
    if (NextIndex >= MaxMonsterCount) {
        NextIndex = 0;
        pNextMonster = Monsters;
    }
}

static void Show(ptr<Monster> pMonster)
{
    byte pattern = pMonster->status & Actor_PatternMask;
    if (pMonster->dx != 0 || pMonster->dy != 0) {
        byte seq = ((pMonster->x | pMonster->y) >> CoordShift) & 1;
        pattern += seq;
    }
    ShowSprite(pMonster, pattern + Pattern_Monster);
}

void StartMonster()
{
    repeat (MaxMonsterCount) {
        byte status = pNextMonster->status;
        if (
            (status & Monster_Available) != 0 &&
            (status & (Monster_Start | Monster_Live)) == 0
        ) {
            byte sprite = Sprite_Monster;
            repeat (MonsterSpriteCount) {
                ptr<Monster> p;
                for (p : Monsters) {
                    if (
                        (p->status & (Monster_Start | Monster_Live)) != 0 &&
                        p->sprite == sprite 
                    ) goto inUse;
                }
                pNextMonster->x = pNextMonster->startX;
                pNextMonster->y = pNextMonster->startY;
                pNextMonster->sprite = sprite;
                pNextMonster->status = Monster_Start | Monster_Available;
                pNextMonster->dx = 0;
                pNextMonster->dy = 0;
                pNextMonster->count = TimerValue;
                // Show(pNextMonster);
                return;
                
                inUse:
                ++sprite;
            }
            break;
        }
        Next();
    }
}

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
            if (CanMoveEnemy(pMonster, dx, dy)) {
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

void InitMonsters()
{
    {
        byte sprite = Sprite_Monster;
        repeat (MonsterSpriteCount) {
            HideSprite(sprite); ++sprite;
        }
    }
    {
        ptr<Monster> pMonster = Monsters;
        byte i = 0;
        ptr<byte> p = pStage->pMonsters;
        byte count = pStage->monsterCount;
        do {
            byte b = *p; ++p;
            LocateActor(pMonster, b);
            pMonster->status = Monster_Available;
            pMonster->startX = pMonster->x;
            pMonster->startY = pMonster->y;
            ++pMonster;
            ++i;
            --count;
        } while (count != 0);
        while (i < MaxMonsterCount) {
            pMonster->status = 0;
            ++pMonster;
            ++i;
        }
    }
    pNextMonster = Monsters;
    NextIndex = 0;
    repeat (MonsterSpriteCount) {
        StartMonster();
    }
    {
        ptr<Monster> pMonster;
        for (pMonster : Monsters) {
            if ((pMonster->status & Monster_Start) != 0) {
                pMonster->status |= Monster_Live;
                DecideDirection(pMonster);
                Show(pMonster);
            }
        }
    }
    Clock = 0;
}


void MoveMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Monster_Live) != 0) {
            if (((pMonster->x | pMonster->y) & GridCoordMask) == 0) {
                DecideDirection(pMonster);
                HitMan(pMonster->x, pMonster->y);
            }
            MoveActor(pMonster);
            Show(pMonster);
            if (((pMonster->x | pMonster->y) & CoordMask) == 0) {
                HitMan(pMonster->x, pMonster->y);
            }
        }
        else if ((status & Monster_Start) != 0) {
            if ((Clock & CoordMask) == 0) {
                byte count = pMonster->count;
                if (count != 0) {
                    if (count << 2 < TimerValue) {
                        if ((count & 1) == 0) {
                            Show(pMonster);
                        }
                        else {
                            HideSprite(pMonster->sprite);
                        }
                    }
                    --pMonster->count;
                }
                else {
                    status &= ~Monster_Start;
                    status |= Monster_Live;
                    pMonster->status = status;
                    pMonster->x = pMonster->startX;
                    pMonster->y = pMonster->startY;
                    DecideDirection(pMonster);
                    Show(pMonster);
                }
            }
        }
    }
    ++Clock;
}


bool IsBlockedByMonster(ptr<Actor> pActor, byte column, byte row)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if (pMonster != pActor) {
            if ((pMonster->status & (Monster_Live | Monster_Start)) != 0) {
                byte monsterColumn = (pMonster->x >> GridCoordShift);
                byte monsterRow = (pMonster->y >> GridCoordShift);
                if (monsterColumn == column && monsterRow == row) {
                    return true;
                }
                if (monsterColumn + pMonster->dx == column && monsterRow + pMonster->dy == row) {
                    return true;
                }
            }
        }
    }
    return false;
}


void HitMonsters(byte x, byte y)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->status & Monster_Live) != 0) {
            if (IsNear(pMonster, x, y)) {
                pMonster->status &= ~(Monster_Live | Monster_Start);
                HideSprite(pMonster->sprite);
                Sound_Hit();
                StartPoint(pMonster->x, pMonster->y);
                StartMonster();
                StartOneUp();
            }
        }
    }
}
