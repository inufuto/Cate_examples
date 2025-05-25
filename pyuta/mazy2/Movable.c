#include "Movable.h"
#include "Stage.h"
#include "Vram.h"

void LocateMovable(word pMovable, byte b)
{
    byte column = b >> 4;
    byte row = b & 0x0f;
    WriteVram(pMovable + Movable_x, ToCoord(column) << CoordShift);
    WriteVram(pMovable + Movable_y, ToCoord(row) << CoordShift);
}


void MoveMovable(word pMovable)
{
    WriteVram(pMovable + Movable_x, ReadVram(pMovable + Movable_x) + ReadVram(pMovable + Movable_dx));
    WriteVram(pMovable + Movable_y, ReadVram(pMovable + Movable_y) + ReadVram(pMovable + Movable_dy));
}


bool CanMove(word pMovable, sbyte dx, sbyte dy)
{
    byte x = ReadVram(pMovable + Movable_x);
    byte y = ReadVram(pMovable + Movable_y);
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
                if ((ReadVram(CellMapPtr(column, row)) & Cell_LeftWall) != 0) {
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
                if ((ReadVram(CellMapPtr(column, row)) & Cell_RightWall) != 0) {
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
                if ((ReadVram(CellMapPtr(column, row)) & Cell_TopWall) != 0) {
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
                if ((ReadVram(CellMapPtr(column, row)) & Cell_BottomWall) != 0) {
                    return false;
                }
            }
            return true;
        }
    }
}
