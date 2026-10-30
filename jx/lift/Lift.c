#include "Movable.h"
#include "Actor.h"
#include "Lift.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Chars.h"
#include "Sprite.h"
#include "Man.h"
#include "Monster.h"
#include "VVram.h"

constexpr byte InvalidX = 0xff;

Lift[MaxLiftCount] Lifts;
byte LiftCount;


static void Show(ptr<Lift> pLift)
{
    ShowSprite(&pLift->_, Pattern_Lift);
}

void InitLifts()
{
    ptr<Lift> pLift;
    byte count, i, sprite;
    ptr<byte> p;
    pLift = Lifts;
    i = 0;
    sprite = Sprite_Lift;
    p = pStage->pLifts;
    while (i < pStage->liftCount) {
        byte b;
        ptr<byte> pVram;
        b = *p; ++p;
        pLift->x = ToX(b);
        pLift->top = ToY(b) + 1;
        b = *p; ++p;
        pLift->bottom = ToY(b) + 3;
        pLift->_.x = pLift->x << CoordShift;
        pLift->_.y = (((b & 0x0f) << 2) + 3 + StageTop) << CoordShift;
        pLift->_.sprite = sprite;
        pLift->_.clock = 0;
        pVram = VVramPtr(pLift->x, pLift->bottom);
        repeat (2) {
            *pVram = Char_LiftBottom;
            ++pVram;
        }
        Show(pLift);
        {
            byte y;
            ptr<byte> pCell;
            y = pLift->bottom;
            pCell = CellMapPtr(pLift->x, y);
            *pCell = (*pCell & ~Cell_Type) | Cell_Type_LiftBottom | (i & 7);
            pCell -= ColumnCount;
            y -= FloorHeight;
            while (y >= pLift->top) {
                *pCell = (*pCell & ~Cell_Type) | Cell_Type_LiftBit | (i & 7);
                pCell -= ColumnCount;
                y -= FloorHeight;
            }
        }
        ++pLift;
        ++i;
        ++sprite;
    }
    LiftCount = i;
    while (i < MaxLiftCount) {
        pLift->x = InvalidX;
        ++pLift;
        ++i;
    }
}


void MoveLifts()
{
    ptr<Lift> pLift;
    for (pLift: Lifts) {
        if ((pLift->x == InvalidX)) continue;
        --pLift->_.y;
        if ((pLift->_.y >> CoordShift) < pLift->top) {
            pLift->_.y = pLift->bottom << CoordShift;
        }
        Show(pLift);
        MoveManOnLift(&pLift->_);
        MoveMonstersOnLift(&pLift->_);
        ++pLift->_.clock;
    }
}


bool IsOnAnyLift(ptr<Actor> pActor)
{
    ptr<Lift> pLift;
    for (pLift: Lifts) {
        if ((pLift->x == InvalidX)) continue;
        if (IsOnLift(pActor, &pLift->_)) {
            return true;
        }
    }
    return false;
}