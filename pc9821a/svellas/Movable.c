#include "Movable.h"
#include "Stage.h"

extern void _deb();

constexpr byte HitRange = (CoordRate * 4 / 3);

void LocateMovable(ptr<Movable> pMovable, byte b)
{
    byte column = b >> 4;
    byte row = b & 0x0f;
    pMovable->x = ToCoord(column) << CoordShift;
    pMovable->y = ToCoord(row) << CoordShift;
}


void MoveMovable(ptr<Movable> pMovable)
{
    pMovable->x += pMovable->dx;
    pMovable->y += pMovable->dy;
}


bool CanMoveMovable(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte x = pMovable->x >> CoordShift;
    byte y = pMovable->y >> CoordShift;
    byte xMod = x & 3;
    if (xMod == 0) {
        if (dy != 0) return false;
        if (dx < 0) {
            byte column = x >> 2;
            if (column == 0) return false;
            byte row = y >> 2;
            byte left = *MapPtr(column - 1, row);
            return left != 0 && (left & Panel_Right) == 0;
        }
        return true;
    }
    if (xMod == 2) {
        if (dy != 0) return false;
        if (dx > 0) {
            byte column = x >> 2;
            if (column == ColumnCount - 1) return false;
            byte row = y >> 2;
            byte right = *MapPtr(column + 1, row);
            return right != 0 && (right & Panel_Left) == 0;
        }
        return true;
    }
    if (xMod == 3) {
        return dy == 0;
    }
    byte yMod = y & 3;
    if (yMod == 0) {
        if (dx != 0) return false;
        if (dy < 0) {
            byte row = y >> 2;
            if (row == 0) return false;
            byte column = x >> 2;
            byte upper = *MapPtr(column, row - 1);
            return upper != 0 && (upper & Panel_Bottom) == 0;
        }
        return true;
    }
    if (yMod == 2) {
        if (dx != 0) return false;
        if (dy > 0) {
            byte row = y >> 2;
            if (row == RowCount - 1) return false;
            byte column = x >> 2;
            byte lower = *MapPtr(column, row + 1);
            return lower != 0 && (lower & Panel_Top) == 0;
        }
        return true;
    }
    if (yMod == 3) {
        return dx == 0;
    }
    byte row = y >> 2;
    byte column = x >> 2;
    byte panel = *MapPtr(column, row);
    if (dx < 0) {
        return (panel & Panel_Left) == 0;
    }
    if (dx > 0) {
        return (panel & Panel_Right) == 0;
    }
    if (dy < 0) {
        return (panel & Panel_Top) == 0;
    }
    if (dy > 0) {
        return (panel & Panel_Bottom) == 0;
    }
    return true;
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}
