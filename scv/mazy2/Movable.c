#include "Movable.h"
#include "Stage.h"

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


bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte x = pMovable->x;
    byte y = pMovable->y;
    if (dy == 0) {
        byte yMod = CoordMod(y);
        if (yMod != 0) return false;
        byte xMod = CoordMod(x);
        if (dx < 0) {
            if (xMod == 0) {
                byte column = ToGrid(x);
                if (column == 0) {
                    return false;
                }
                byte row = ToGrid(y);
                if ((*CellMapPtr(column, row) & Cell_LeftWall) != 0) {
                    return false;
                }
            }
            return true;
        }
        else {
            if (xMod == 0) {
                byte column = ToGrid(x);
                if (column >= ColumnCount - 1) {
                    return false;
                }
                byte row = ToGrid(y);
                if ((*CellMapPtr(column, row) & Cell_RightWall) != 0) {
                    return false;
                }
            }
            return true;
        }
    }
    else if (dx == 0) {
        byte xMod = CoordMod(x);
        if (xMod != 0) return false;
        byte yMod = CoordMod(y);
        if (dy < 0) {
            if (yMod == 0) {
                byte row = ToGrid(y);
                if (row == 0) {
                    return false;
                }
                byte column = ToGrid(x);
                if ((*CellMapPtr(column, row) & Cell_TopWall) != 0) {
                    return false;
                }
            }
            return true;
        }
        else {
            if (yMod == 0) {
                byte row = ToGrid(y);
                if (row >= RowCount - 1) {
                    return false;
                }
                byte column = ToGrid(x);
                if ((*CellMapPtr(column, row) & Cell_BottomWall) != 0) {
                    return false;
                }
            }
            return true;
        }
    }
}
