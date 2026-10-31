#include "Movable.h"
#include "Stage.h"

extern void _deb();

constexpr byte HitRange = (CoordRate * 4 / 3);
byte NextCell;

void LocateMovable(ptr<Movable> pMovable, byte b)
{
    pMovable->x = (b & 0xf0) >> (3 - CoordShift);
    pMovable->y = ((((b & 15) << 2) + CellSize) << CoordShift);
}


bool IsNearXY(byte x, byte y, ptr<Movable> p2)
{
    return
        x + CoordRate * 2 >= p2->x && p2->x + CoordRate * 2 >= x &&
        y + CoordRate * 2 >= p2->y && p2->y + CoordRate * 2 >= y;
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
    NextCell = 0;
    byte x = pMovable->x;
    if ((x & CellCoordMask) != 0) return dy == 0;
    byte y = pMovable->y;
    if ((y & CellCoordMask) != 0) return dx == 0;
    byte column = x >> CellCoordShift;
    if (dx < 0 && column == 0) return false;
    if (dx > 0 && column >= ColumnCount - 1) return false;
    byte row = y >> CellCoordShift;
    if (dy > 0 && row >= RowCount - 1) return false;
    if ((pMovable->status & Movable_Fall) == 0) {
        byte nextColumn = column + dx;
        byte nextRow = row + dy;
        byte nextCell = GetCell(nextColumn, nextRow);
        if ((nextCell & Cell_Block) != 0) {
            NextCell = nextCell;
            return false;
        }
        if ((nextRow & 1) == 0) {
            if ((nextCell & Cell_Ceiling) != 0) return false;
        }
        if (dy < 0) {
            if ((nextCell & Cell_Down) == 0) return false;
        }
    }
    return true;
}


bool FallMovable(ptr<Movable> pMovable)
{
    byte column = pMovable->x >> CellCoordShift;
    byte nextRow = (pMovable->y >> CellCoordShift) + 1;
    if (nextRow >= RowCount) goto stop;
    byte nextCell = GetCell(column, nextRow);
    if ((nextRow & 1) != 0) {
        nextCell &= ~Cell_Item;
    }
    if (nextCell == 0) {
        pMovable->status |= Movable_Fall;
        return true;
    }
    else {
        stop:
        pMovable->status &= ~Movable_Fall;
        return false;
    }
    return (pMovable->status & Movable_Fall) != 0;
}


bool InRange(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte column = (pMovable->x >> CellCoordShift) + dx;
    if (column >= ColumnCount) return false;
    byte row = (pMovable->y >> CellCoordShift) + dy;
    return row < RowCount;
}