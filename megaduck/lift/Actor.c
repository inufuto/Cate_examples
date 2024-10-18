#include "Movable.h"
#include "Actor.h"
#include "Stage.h"
#include "Lift.h"

extern void _deb();

bool CanMoveTo(ptr<Actor> pActor, sbyte dx)
{
    byte x, y;
    x = (pActor->_.x >> CoordShift) + dx + dx;
    y = pActor->_.y >> CoordShift;
    if (x >= ColumnCount * 2) return false;
    if (y >= StageTop) {
        byte cell;
        cell = *CellMapPtr(x, y);
        if ((cell & Cell_Type_LiftBit) != 0) {
            byte liftY;
            liftY = Lifts[cell & Cell_Index]._.y;
            return 
                liftY + CoordRate < pActor->_.y ||
                pActor->_.y + CoordRate * 2 < liftY;
        }
        if ((cell & Cell_Type_Floor) != 0) {
            return 
                (pActor->_.y & CoordMask) == 0 && 
                ((((pActor->_.y + CoordMask) >> CoordShift) - StageTop) & 3) < 3;
        }
    }
    return true;
}


bool IsOnLift(ptr<Actor> pActor, ptr<Movable> pLift)
{
    constexpr byte Width = 2 * CoordRate;
    constexpr byte LeftEnd = ColumnCount * CoordRate * 2 - CoordRate * 2;
    byte bottom;
    bottom = pActor->_.y + CoordRate * 2;
    if (
        pLift->y >= bottom - CoordRate &&
        bottom >= pLift->y
    ) {
        if (pLift->x < CoordRate * 2) {
            return pActor->_.x < CoordRate * 2;
        }
        if (pLift->x >= LeftEnd) {
            return pActor->_.x >= LeftEnd;
        }
        return 
            pActor->_.x + Width > pLift->x &&
            pActor->_.x< pLift->x + Width;
    }
    return false;
}

bool MoveOnLift(ptr<Actor> pActor, ptr<Movable> pLift)
{
    constexpr byte Width = 2 * CoordRate;
    if (IsOnLift(pActor, pLift)) {
        pActor->_.y = pLift->y - CoordRate * 2;
        return true;
    }
    return false;
}


void Fall(ptr<Actor> pActor)
{
    ptr<byte> pCell;
    byte x, y, count;
    bool fall;
    y = pActor->_.y >> CoordShift;
    if (y < StageTop) goto move;
    if (y >= StageBottom + 1) return;
    fall = true;
    x = pActor->_.x >> CoordShift;
    pCell = CellMapPtr(x, y);
    count = (x & 1) == 0 ? 1 : 2;
    if ((pActor->_.x & CoordMask) != 0) ++count;
    do {
        byte cell;
        cell = *pCell; ++pCell;
        if ((cell & Cell_Type_LiftBit) != 0) {
            if (IsOnLift(pActor, &Lifts[cell & Cell_Index]._)) {
                fall = false;
                break;
            }
        }
        if ((cell & Cell_Type_Floor) != 0) {
            if (((y - StageTop) & 3) == 1 && (pActor->_.y & CoordMask) == 0) {
                fall = false;
                break;
            }
        } 
        --count;
    } while (count != 0);
    if (fall) {
        move:
                            _deb();
        ++pActor->_.y;
    }
}