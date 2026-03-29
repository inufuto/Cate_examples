#include "Movable.h"
#include "Stage.h"
#include "Lift.h"

extern void _deb();

constexpr byte HitRangeX = 1;
constexpr byte HitRangeY = HitRangeX * CoordRate;

byte GetCellAtFloor(ptr<Movable> pMovable, byte floor)
{
    byte column;
    if (floor >= FloorCount) return Cell_Space;
    column = XToColumn(pMovable->x);
    if (pMovable->xd != 0 || (pMovable->x & 1) != 0) {
        byte left, right;
        left = GetCell(column, floor);
        right = GetCell(column + 1, floor);
        if (left == Cell_Needle || right == Cell_Needle) {
            return Cell_Needle;
        }
        if (left == Cell_Item || right == Cell_Item) {
            return Cell_Item;
        }
        return  left | right;
    }
    else {
        return GetCell(column, floor);
    }
}


byte GetCellAt(ptr<Movable> pMovable)
{
    byte y;
    y = pMovable->y;
    if ((y & CoordMask) != 0) return Cell_Space;
    y >>= CoordShift;
    if (y < StageTop) return Cell_Space;
    if (((y - StageTop) & FloorMask) != Offset_Head) return Cell_Space;
    return GetCellAtFloor(pMovable, YToFloor(pMovable->y));
}


bool IsFloor(ptr<Movable> pMovable, byte floor)
{
    return GetCellAtFloor(pMovable, floor) != Cell_Space;
}


bool IsOnFloor(ptr<Movable> pMovable)
{
    return GetCellAt(pMovable) != Cell_Space;
}


bool IsNeedle(ptr<Movable> pMovable, byte floor)
{
    return GetCellAtFloor(pMovable, floor) == Cell_Needle;
}


bool IsOnNeedle(ptr<Movable> pMovable)
{
    return GetCellAt(pMovable) == Cell_Needle;
}


bool CanMoveX(ptr<Movable> pMovable, sbyte dx)
{
    byte newX, y, floor, column;
    newX = pMovable->x + dx;
    if (newX >= StageWidth - 1) return false;
    y = pMovable->y;
    y >>= CoordShift;
    if (y < StageTop) return true;
    y -= StageTop;
    if ((y & FloorMask) < 1) return true;
    if ((newX & 1) != 0 && dx > 0) ++newX;
    column = XToColumn(newX);
    return GetCell(column, y >> FloorShift) != Cell_Needle;
}


bool MoveX(ptr<Movable> pMovable, sbyte dx)
{
    pMovable->xd += dx;
    if (pMovable->xd >= CoordRate) {
        pMovable->x += dx;
        pMovable->xd &= CoordMask;
        return true;
    }
    return false;
}


bool IsNexrX(byte x1, byte x2)
{
    constexpr byte Width = 1;
    return x1 + HitRangeX >= x2 && x2 + HitRangeX >= x1;
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRangeX >= p2->x && p2->x + HitRangeX >= p1->x &&
        p1->y + HitRangeY >= p2->y && p2->y + HitRangeY >= p1->y;
}
