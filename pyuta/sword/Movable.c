#include "Movable.h"
#include "Stage.h"
#include "Vram.h"

constexpr byte HitRange = (CoordRate * 4 / 3);

void LocateActor(word pActor, byte b)
{
    WriteVram(pActor + Movable_x, ToColumn(b) << GridCoordShift);
    WriteVram(pActor + Movable_y, ToRow(b) << GridCoordShift);
}

void MoveActor(word pActor)
{
    sbyte dx = ReadVram(pActor + Actor_dx);
    sbyte dy = ReadVram(pActor + Actor_dy);
    WriteVram(pActor + Movable_x, ReadVram(pActor + Movable_x) + dx);
    WriteVram(pActor + Movable_y, ReadVram(pActor + Movable_y) + dy);
}

byte NextCell(word pActor, sbyte dx, sbyte dy)
{
    byte x = ReadVram(pActor + Movable_x);
    if ((x & GridCoordMask) != 0) return Cell_Space;
    byte column = x >> GridCoordShift;
    if (dx < 0) {
        if (column == 0) return Cell_Wall;
    }
    else if (dx != 0) {
        if (column >= ColumnCount - 1) return Cell_Wall;
    } 
    
    byte y = ReadVram(pActor + Movable_y);
    if ((y & GridCoordMask) != 0) return Cell_Space;
    byte row = y >> GridCoordShift;
    if (dy < 0) {
        if (row == 0) return Cell_Wall;
    } 
    else if (dy != 0) {
        if (row >= RowCount - 1) return Cell_Wall;
    }
    return GetCell(column + dx, row + dy);
}

bool IsNear(word pMovable, byte x, byte y)
{
    return
        ReadVram(pMovable + Movable_x) + HitRange >= x && x + HitRange >= ReadVram(pMovable + Movable_x) &&
        ReadVram(pMovable + Movable_y) + HitRange >= y && y + HitRange >= ReadVram(pMovable + Movable_y);
}