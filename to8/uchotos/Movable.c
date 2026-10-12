#include "Movable.h"
#include "Stage.h"

constexpr byte HitRange = (CoordRate * 4 / 3);

byte NextCell;

void LocateMovable(ptr<Movable> pMovable, byte b)
{
    pMovable->x = (b & 0xf0) >> (3 - CoordShift);
    pMovable->y = (((b & 0x0f) << 2) << CoordShift);
}


bool IsOnGrid(ptr<Movable> pMovable)
{
    return (pMovable->x & CellCoordMask) == 0 && (pMovable->y & CellCoordMask) == 0;
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
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
    if (dx > 0 && column + 1 >= ColumnCount) return false;
    byte row = y >> CellCoordShift;
    if (dy < 0 && row == 0) return false;
    if (dy > 0 && row + 2 >= RowCount) return false;

    byte nextColumn = column + dx;
    byte nextRow = row + dy;
    NextCell = GetCell(nextColumn, nextRow);
    return NextCell != Cell_Floor;
}
