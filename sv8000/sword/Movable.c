#include "Movable.h"
#include "Stage.h"

constexpr byte HitRange = (CoordRate * 4 / 3);

void LocateActor(ptr<Actor> pActor, byte b)
{
    pActor->x = ToColumn(b) << GridCoordShift;
    pActor->y = ToRow(b) << GridCoordShift;
}

void MoveActor(ptr<Actor> pActor)
{
    pActor->x += pActor->dx;
    pActor->y += pActor->dy;
}

byte NextCell(ptr<Actor> pActor, sbyte dx, sbyte dy)
{
    byte x = pActor->x;
    if ((x & GridCoordMask) != 0) return Cell_Space;
    byte column = x >> GridCoordShift;
    if (dx < 0) {
        if (column == 0) return Cell_Wall;
    }
    else if (dx != 0) {
        if (column >= ColumnCount - 1) return Cell_Wall;
    } 
    
    byte y = pActor->y;
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

bool IsNear(ptr<Movable> pMovable, byte x, byte y)
{
    return
        pMovable->x + HitRange >= x && x + HitRange >= pMovable->x &&
        pMovable->y + HitRange >= y && y + HitRange >= pMovable->y;
}