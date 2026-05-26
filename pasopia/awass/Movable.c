#include "Movable.h"
#include "Stage.h"

extern void _deb();

constexpr byte ColumnCoordShift = ColumnShift + CoordShift;
constexpr byte FloorCoordShift = FloorShift + CoordShift;
constexpr byte RowCoordShift = RowShift + CoordShift;
constexpr byte ColumnCoordMask = ColumnWidth * CoordRate - 1;
constexpr byte FloorCoordMask = FloorHeight * CoordRate - 1;
constexpr byte RowCoordMask = RowHeight * CoordRate - 1;

constexpr byte HitRange = (CoordRate * 4 / 3);

byte NextCell;

void LocateActor(ptr<Actor> pActor, byte b)
{
    pActor->x = ToColumn(b) << ColumnCoordShift;
    pActor->y = ToFloor(b) << FloorCoordShift;
}


void MoveActor(ptr<Actor> pActor)
{
    pActor->x += pActor->dx;
    pActor->y += pActor->dy;
}


bool CanMove(ptr<Actor> pActor, sbyte dx, sbyte dy)
{
    NextCell = Cell_Blank;
    byte x = pActor->x;
    if ((x & ColumnCoordMask) != 0) return dy == 0;
    byte column = x >> ColumnCoordShift;
    if (dx < 0) {
        if (column == 0) return false;
    }
    else if (dx != 0) {
        if (column >= ColumnCount - 1) return false;
    } 
    
    byte y = pActor->y;
    if ((y & RowCoordMask) != 0) return dx == 0;
    byte row = y >> RowCoordShift;
    if (dy < 0) {
        if (row == 0) return false;
    } 
    else if (dy != 0) {
        if (row >= RowCount - 2) return false;
    }

    if ((pActor->status & Actor_Fall) == 0) {
        byte nextColumn = column + dx;
        byte nextRow = row + dy;
        NextCell = GetCell(nextColumn, nextRow);
        switch (NextCell) {
        case Cell_Blank:
            return dy >= 0;
        case Cell_Ladder:
            return dy >= 0 || GetCell(column, row) == Cell_Ladder;
        }
        return false;
    }
    return true;
}


bool FallActor(ptr<Actor> pActor)
{
    byte nextRow = (pActor->y >> RowCoordShift) + 1;
    if (nextRow >= RowCount - 1) goto stop;
    byte x = pActor->x >> CoordShift;
    byte column = x >> ColumnShift;
    if ((x & 1) == 0) {
        if (GetCell(column, nextRow) == Cell_Blank) {
            fall:
            pActor->status |= Actor_Fall;
            return true;
        }
        stop:
        pActor->status &= ~Actor_Fall;
        return false;
    }
    else {
        if (
            GetCell(column, nextRow) == Cell_Blank &&
            GetCell(column + 1, nextRow) == Cell_Blank
        ) goto fall;
        goto stop;
    }
    return (pActor->status & Actor_Fall) != 0;
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}


bool InRange(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte column = (pMovable->x >> ColumnCoordShift) + dx;
    if (column >= ColumnCount) return false;
    byte row = (pMovable->y >> RowCoordShift) + dy;
    return row < RowCount - 1;
}
