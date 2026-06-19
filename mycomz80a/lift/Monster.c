#include "Movable.h"
#include "Actor.h"
#include "Monster.h"
#include "Stages.h"
#include "Stage.h"
#include "Sprite.h"
#include "Chars.h"
#include "Man.h"
#include "Lift.h"

constexpr byte WaitBit = 0x40;

Actor[MaxMonsterCount] Monsters;
byte MonsterCount;
// static byte MonsterClock;

static void Show(ptr<Actor> pMonster)
{
    byte c;
    c = pMonster->c + ((pMonster->status & Actor_SeqMask) << 2);
    ShowSprite(&pMonster->_, c);
}


static bool IsNearOther(ptr<Actor> pMonster)
{
    ptr<Actor> p;
    for (p: Monsters) {
        if ((p->status & Actor_Live) == 0) continue;
        if (p->_.sprite >= pMonster->_.sprite) continue;
        if (IsNear(&pMonster->_, &p->_)) return true;
    }
    return false;
}


static void DecideDirection(ptr<Actor> pMonster)
{   
    sbyte dx;
    byte x, y, wait;
    wait = pMonster->status & WaitBit;
    x = pMonster->_.x >> CoordShift;
    y = pMonster->_.y >> CoordShift;
    dx = pMonster->dx;
    if (dx == 0) {
        if (Man._.y < pMonster->_.y) {
            if (IsOnAnyLift(pMonster)) {
                wait = WaitBit;
            }
            else {
                byte cell, flags;
                cell = *CellMapPtr(x, y);
                if ((cell & Cell_Type_Floor) == 0) {
                    flags = Cell_LeftLift | Cell_RightLift;
                }
                else {
                    flags = cell & (Cell_LeftLift | Cell_RightLift);
                }
                if (flags == Cell_LeftLift || Man._.x < pMonster->_.x) {
                    dx = -1;
                }
                else if (flags == Cell_RightLift || Man._.x > pMonster->_.x) {
                    dx = 1;
                }
            }
        }
        else {
            if (Man._.x < pMonster->_.x) {
                dx = -1;
            }
            else if (Man._.x > pMonster->_.x) {
                dx = 1;
            }
        }
    }
    if (Man._.y < pMonster->_.y) {
        byte cell;
        cell = *CellMapPtr(x, y);
        if ((cell & Cell_Type_LiftBit) != 0) {
            if (Lifts[cell & Cell_Index]._.y <= pMonster->_.y) {
                wait = WaitBit;
                dx = 0;
            }
        }
    }
    else {
        wait = 0;
    }
    if (wait == 0) {
        if (!CanMoveTo(pMonster, dx)) {
            if (wait == 0 && CanMoveTo(pMonster, -dx)) {
                dx = -dx;
            }
            else {
                dx = 0;
            }
        }
    }
    if (dx < 0) {
        pMonster->c = Char_Monster_Left;
    }
    else if (dx > 0) {
        pMonster->c = Char_Monster_Right;
    }
    pMonster->dx = dx;
    pMonster->status = (pMonster->status & ~WaitBit) | wait;
}


void InitMonsters()
{
    ptr<Actor> pMonster;
    byte count, i, sprite;
    ptr<byte> p;
    pMonster = Monsters;
    i = 0;
    sprite = Sprite_Monster;
    p = pStage->pMonsters;
    while (i < pStage->monsterCount) {
        byte b;
        b = *p; ++p;
        pMonster->_.x = ToX(b) << CoordShift;
        pMonster->_.y = (ToY(b) + 1) << CoordShift;
        pMonster->_.sprite = sprite;
        pMonster->_.clock = 0;
        pMonster->dx = 0;
        pMonster->status = Actor_Live;
        pMonster->c = Char_Monster_Right;
        DecideDirection(pMonster);
        Show(pMonster);
        ++pMonster;
        ++i;
        ++sprite;
    }
    MonsterCount = i;
    while (i < MaxMonsterCount) {
        pMonster->status = 0;
        ++pMonster;
        ++i;
    }
}


void MoveMonsters()
{
    ptr<Actor> pMonster;
    for (pMonster: Monsters) {
        byte wait;
        if ((pMonster->status & Actor_Live) == 0) continue;
        HitMan(&pMonster->_);
        if (IsOnGrid(&pMonster->_)) {
            if (!IsNearOther(pMonster)) {
                DecideDirection(pMonster);
            }
            else if ((pMonster->status & WaitBit) == 0) {
                if (!CanMoveTo(pMonster, pMonster->dx << CoordShift * 2)) {
                    pMonster->dx = 0;
                }
            }
        }
        if (pMonster->dx != 0 && (pMonster->status & WaitBit) == 0) {
            byte seq;
            pMonster->_.x += pMonster->dx;
            seq = ((pMonster->_.x + CoordRate / 2) >> CoordShift) & 1;
            pMonster->status = (pMonster->status & ~Actor_SeqMask) | seq;
            HitMan(&pMonster->_);
        }
        Show(pMonster);
        ++pMonster->_.clock;
    }
}


void FallMonsters()
{
    ptr<Actor> pMonster;
    for (pMonster: Monsters) {
        if ((pMonster->status & Actor_Live) == 0) continue;
        Fall(pMonster);
        Show(pMonster);
    }
}


void MoveMonstersOnLift(ptr<Movable> pLift)
{
    ptr<Actor> pMonster;
    for (pMonster: Monsters) {
        if ((pMonster->status & Actor_Live) == 0) continue;
        if (MoveOnLift(pMonster, pLift)) {
            Show(pMonster);
        }
    }
}