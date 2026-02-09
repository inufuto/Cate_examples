#include "Movable.h"
#include "Stage.h"

extern void _deb();

constexpr byte HitRange = (CoordRate * 4 / 3);

void LocateMovable(ptr<Movable> pMovable, byte b)
{
    pMovable->x = (b & 0xf0) >> (3 - CoordShift);
    pMovable->y = ((((b & 15) << 2)) << CoordShift) + CoordRate;
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}


void MoveMovable(ptr<Movable> pMovable)
{
    pMovable->x += pMovable->dx;
    pMovable->y += pMovable->dy;
}


bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte x;
    if (dx < 0 && pMovable->x == 0) return false;
    if (dx > 0 && pMovable->x >= (StageWidth - 2) * CoordRate) return false;
    if ((pMovable->status & Movable_Fall) == 0) {
        byte y;
        y = pMovable->y >> CoordShift;
        if (dx != 0) {
            return (y & FloorMask) == 1;
        }
        x = pMovable->x >> CoordShift;
        if (dy < 0) {
            if ((x & ColumnMask) != 0) return false;
            return (GetCell(x >> ColumnShift, (y + 2) >> FloorShift) & Cell_UpperMask) == Cell_LadderUp;
        }
        if (dy > 0) {
            if ((x & ColumnMask) != 0) return false;
            if ((y & FloorMask) != 1) return true;
            return (GetCell(x >> ColumnShift, y >> FloorShift) & Cell_LowerMask) == Cell_LadderDown;
        }
    }
    return true;
}


bool FallMovable(ptr<Movable> pMovable)
{
    byte x, y;
    x = pMovable->x >> CoordShift;
    y = pMovable->y >> CoordShift;
    if ((x & ColumnMask) == 0 && (y & FloorMask) == 1) {
        byte lower;
        lower = GetCell(x >> ColumnShift, y >> FloorShift) & Cell_LowerMask;
        if (lower == Cell_Space) {
                _deb();
            pMovable->status |= Movable_Fall;
            return true;
        }
        else {
            pMovable->status &= ~Movable_Fall;
            return false;
        }
    }
    return (pMovable->status & Movable_Fall) != 0;
}