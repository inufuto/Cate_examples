#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Math.h"
#include "Man.h"
#include "Chars.h"
#include "Sprite.h"
#include "Point.h"
#include "Sound.h"

extern void _deb();

constexpr byte Monster_Freeze = 0x10;
constexpr byte Monster_Return = 0x20;
constexpr byte FreezeTime = 30 * CoordRate;
Monster[MaxMonsterCount] Monsters;

static void DecideDirection(ptr<Monster> pMonster)
{
    byte[4] directions;
    byte targetX, targetY;
    if ((Man.status & Actor_Live) != 0 && (pMonster->_.status & Monster_Return) == 0) {
        targetX = Man._.x;
        targetY = Man._.y;
    }
    else {
        targetX = pMonster->startX;
        targetY = pMonster->startY;
    }
    if (Abs(targetX, pMonster->_._.x) > Abs(targetY, pMonster->_._.y)) {
        byte verticalDirectionIndex;
        if (targetX < pMonster->_._.x) {
            if (pMonster->_.dx <= 0) {
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
            if (pMonster->_.dx >= 0) {
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
        if (targetY < pMonster->_._.y && pMonster->_.dy <= 0 || pMonster->_.dy < 0) {
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
        if (targetY < pMonster->_._.y) {
            if (pMonster->_.dy <= 0) {
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
            if (pMonster->_.dy >= 0) {
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
        if (targetX < pMonster->_._.y && pMonster->_.dx <= 0 || pMonster->_.dx < 0) {
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
            if (CanMove(&pMonster->_, direction)) {
                SetDirection(&pMonster->_, direction);
                return;
            }
        }
    }
    pMonster->_.dx = 0;
    pMonster->_.dy = 0;
}

static void Show(ptr<Monster> pMonster)
{
    byte pattern;
    byte status;
    status = pMonster->_.status;
    pattern = ((status & Actor_PatternMask) << 2) + Char_Monster;
    ShowSprite(&pMonster->_._, pattern);
}


void InitMonsters()
{
    ptr<byte> p;
    ptr<Monster> pMonster;
    byte count, i, sprite;

    p = pStage->pMonsters;
    pMonster = Monsters;
    count = pStage->monsterCount;
    i = 0;
    sprite = Sprite_Monster;
    while (i < count) {
        pMonster->_.status = Actor_Live;
        pMonster->_._.sprite = sprite;
        pMonster->_.dx = 0;
        pMonster->_.dy = 0;
        LocateMovable(&pMonster->_._, *p); ++p;
        DecideDirection(pMonster);
        Show(pMonster);
        pMonster->startX = pMonster->_._.x;
        pMonster->startY = pMonster->_._.y;
        ++sprite;
        ++i;
        ++pMonster;
    }
    while (i < MaxMonsterCount) {
        pMonster->_.status = 0;
        pMonster->_._.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++i;
        ++pMonster;
    }
}


void MoveMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status;
        status = pMonster->_.status;
        if ((status & Actor_Live) != 0) {
            if ((status & Monster_Freeze) == 0) {
                if (IsOnCellGrid(&pMonster->_._)) {
                    DecideDirection(pMonster);
                }
                Move(&pMonster->_);
                Show(pMonster);
                if (IsOnCoordGrid(&pMonster->_._)) {
                    if (HitMan(&pMonster->_._)) {
                        pMonster->_.status |= Monster_Return;
                    }
                    else if ((pMonster->_.status & Monster_Return) != 0 &&
                        pMonster->_._.x == pMonster->startX &&
                        pMonster->_._.y == pMonster->startY 
                    ) {
                        pMonster->_.status &= ~Monster_Return;
                    }
                }
            }
            else {
                if ((pMonster->_.clock & CoordMask) == 0) {
                    static const byte[] patterns = {
                        Char_Monster + 0 * 4,
                        Char_Monster + 4 * 4,
                        Char_Monster + 2 * 4,
                        Char_Monster + 6 * 4,
                    };
                    byte pattern;
                    pattern = patterns[(pMonster->_.clock >> CoordShift) & 3];
                    ShowSprite(&pMonster->_._, pattern);
                }
                --pMonster->_.clock;
                if (pMonster->_.clock == 0) {
                    pMonster->_.status &= ~Monster_Freeze;
                    Show(pMonster);
                }
            }
        }
    }
}


void HitCarMonsters(ptr<Movable> pMovable)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if (
            (pMonster->_.status & Actor_Live) != 0 &&
            (pMonster->_.status & Monster_Freeze) == 0 &&
            IsNear(pMovable, &pMonster->_._)
        ) {
            pMonster->_.status |= Monster_Freeze;
            pMonster->_.clock = FreezeTime;
            StartPoint(pMonster->_._.x, pMonster->_._.y, 2);
            Sound_Hit();
        }
    }
}


void HitManMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if (
            (pMonster->_.status & Actor_Live) != 0 &&
            (pMonster->_.status & Monster_Freeze) == 0 &&
            HitMan(&pMonster->_._)
        ) {
            pMonster->_.status |= Monster_Return;
        }
    }
}