#include "Movable.h"
#include "Actor.h"
#include "Monster.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Line.h"

constexpr byte Count = Sprite_Point - Sprite_Monster;
constexpr byte HitRange = (CoordRate * 4 / 3);
constexpr byte WeakTime = 40;

byte MonsterCount;
Actor[Count] Monsters;
static byte Clock;

extern void _deb();
void InitMonsters()
{
    ptr<Actor> pMonster;
    byte count, i, sprite;

    pMonster = Monsters;
    count = pStage->enemyCount;
    i = 0;
    sprite = Sprite_Monster;
    while (i < count) {
        pMonster->status = Actor_Live;
        pMonster->_.sprite = sprite;
        ++sprite;
        ++i;
        ++pMonster;
    }
    while (i < Count) {
        pMonster->status = 0;
        pMonster->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++i;
        ++pMonster;
    }
    Clock = 0;
}


static void Show(ptr<Actor> pMonster)
{
    static const byte[] WeakPatterns = {
        Pattern_Monster_Left, 
        Pattern_Monster_Up,
        Pattern_Monster_Right,
        Pattern_Monster_Down,
    };
    byte pattern;
    byte status;
    status = pMonster->status;
    // if ((status & Monster_Weak) != 0) {
    //     byte clock;
    //     clock = pMonster->clock;
    //     if (clock >= WeakTime * 8 / 10 && (clock & 1) == 0) {
    //         HideSprite(pMonster->_.sprite);
    //         return;
    //     }
    //     pattern = WeakPatterns[(clock & 0x06) >> 1];
    // }
    // else {
        pattern = (status & Actor_PatternMask) + Pattern_Monster;
    // }
    ShowSprite(&pMonster->_, pattern);
}


static bool IsNearToMonster(ptr<Actor> pActor, sbyte dx, sbyte dy)
{
    constexpr byte HitRange = 2;
    ptr<Actor> pMonster;
    byte x, y;
    x = (pActor->_.x >> CoordShift) + dx;
    y = (pActor->_.y >> CoordShift) + dy;
    for (pMonster : Monsters) {
        if ((pMonster->status & Actor_Live) != 0) {
            if (pActor != pMonster) {
                byte xx, yy;
                xx = pMonster->_.x >> CoordShift;
                yy = pMonster->_.y >> CoordShift;
                if (
                    x + HitRange >= xx && xx + HitRange >= x &&
                    y + HitRange >= yy && yy + HitRange >= y
                ) return true;
            }
        }
    }
    return false;
}


static bool CanMove(ptr<Actor> pMonster, byte direction)
{
    ptr<sbyte> pElements;
    sbyte dx, dy;
    byte x, y, xMod, yMod;
    pElements = DirectionElements + direction;
    dx = *pElements;
    ++pElements;
    dy = *pElements;
    if (IsNearToMonster(pMonster, dx, dy)) return false;

    x = pMonster->_.x >> CoordShift;
    y = pMonster->_.y >> CoordShift;
    xMod = x & 1;
    yMod = y & 1;
    if (xMod == 0) {
        if (yMod == 0) {
            return (GetCell((x >> 1) + dx, (y >> 1) + dy) & Cell_Mask) == 0;
        }
        if (dx == 0) {
            return (GetCell(x >> 1, (y + dy) >> 1) & (Cell_Mask | Line_Left | Line_Right)) == 0;
        }
        x >>= 1;
        y >>= 1;
        x += dx;
        return GetCell(x, y) == 0 && GetCell(x, y + 1) == 0;
    }
    if (yMod == 0) {
        if (dy == 0) {
            return (GetCell((x + dx) >> 1, y >> 1) & (Cell_Mask | Line_Top | Line_Bottom)) == 0;
        }
        x >>= 1;
        y >>= 1;
        y += dy;
        return GetCell(x, y) == 0 && GetCell(x + 1, y) == 0;
    }
    x >>= 1;
    y >>= 1;
    if (dy == 0) {
        x += dx;
        return 
            (GetCell(x, y) & (Cell_Mask | Line_Bottom)) == 0 &&
            (GetCell(x, y + 1) & (Cell_Mask | Line_Top)) == 0;
    }
    y += dy;
    return 
        (GetCell(x, y) & (Cell_Mask | Line_Right)) == 0 &&
        (GetCell(x + 1, y) & (Cell_Mask | Line_Left)) == 0;
}


static void DecideDirection(ptr<Actor> pMonster)
{
    byte[4] directions;
    byte target;

    if (Abs(Man._.x, pMonster->_.x) > Abs(Man._.y, pMonster->_.y)) {
        byte verticalDirectionIndex;
        if (Man._.x < pMonster->_.x) {
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
        if (Man._.y < pMonster->_.y && pMonster->dy <= 0 || pMonster->dy < 0) {
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
        if (Man._.y < pMonster->_.y) {
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
        if (Man._.x < pMonster->_.y && pMonster->dx <= 0 || pMonster->dx < 0) {
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
            direction = *pDirection;
            if (CanMove(pMonster, direction)) {
                SetDirection(pMonster, direction);
                return;
            }
        }
    }
    pMonster->dx = 0;
    pMonster->dy = 0;
}


void StartMonsters()
{
    ptr<byte> p;
    ptr<Actor> pMonster;
    MonsterCount = 0;
    p = pStage->pEnemies;
    for (pMonster : Monsters) {
        if ((pMonster->status & Actor_Live) != 0) {
            pMonster->status = Actor_Live;
            LocateMovable(&pMonster->_, *p);
            DecideDirection(pMonster);
            Show(pMonster);
            ++MonsterCount;
        }
        ++p;
    }
}


void MoveMonsters()
{
    ptr<Actor> pMonster;
    for (pMonster : Monsters) {
        byte status;
        status = pMonster->status;
        if ((status & Actor_Live) != 0) {
            // if ((status & Monster_Weak) == 0) {
                if (
                    (pMonster->_.x & CoordMask) == 0 &&
                    (pMonster->_.y & CoordMask) == 0
                ) {
                    DecideDirection(pMonster);
                }
                if (pMonster->dx != 0 || pMonster->dy != 0) {
                    byte seq;
                    pMonster->_.x += pMonster->dx;
                    pMonster->_.y += pMonster->dy;
                    seq = ((pMonster->_.x + pMonster->_.y + CoordRate / 2) >> CoordShift) & 1;
                    pMonster->status = (pMonster->status & ~Actor_SeqMask) | seq;
                }
                Show(pMonster);
                if (IsNear(&pMonster->_, &Man._)) {
                    Man.status &= ~Actor_Live;
                }
            // }
            // else {
            //     if ((Clock & CoordMask) == 0) {
            //         byte clock;
            //         clock = pMonster->clock;
            //         ++clock;
            //         if (clock >= WeakTime) {
            //             pMonster->status = status & ~Monster_Weak;
            //         }
            //         else {
            //             pMonster->clock = clock;
            //         }
            //         Show(pMonster);
            //     }
            // }
        }
    }
    ++Clock;
}


// void WeakenMonsters()
// {
//     ptr<Actor> pMonster;
//     for (pMonster : Monsters) {
//         byte status;
//         status = pMonster->status;
//         if ((status & Actor_Live) != 0) {
//             if (IsSurrounded(pMonster->_.x >> CoordShift, pMonster->_.y >> CoordShift)) {
//                 pMonster->status = status | Monster_Weak;
//                 pMonster->clock = 0;
//            }
//         }
//     }
// }