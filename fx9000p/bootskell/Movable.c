#include "Movable.h"
#include "Stage.h"
#include "Man.h"
#include "Block.h"
#include "Monster.h"

constexpr byte HitRange = 3 / 2;

const sbyte[] DirectionElements = {
    -1, 0,
    1,0,
    0,-1,
    0,1,
};


void LocateMovableB(ptr<Movable> pMovable, byte b)
{
    pMovable->x = ((b >> 3) & 0xfe);
    pMovable->y = ((b & 15) << 1);
}


bool IsOnGrid(ptr<Movable> pMovable)
{
    return ((pMovable->x | pMovable->y) & MapMask) == 0;
}


void SetDirection(ptr<Movable> pMovable, byte direction)
{
    ptr<sbyte> pElements;
    pElements = DirectionElements + direction;
    pMovable->status = (pMovable->status & ~Movable_DirectionMask) | direction;
    pMovable->dx = *pElements;
    ++pElements;
    pMovable->dy = *pElements;
}


byte GetCellOrMovable(ptr<Movable> pMovable, byte x, byte y)
{
    byte cell;
    cell = GetCell(x, y);
    if (cell == Cell_None) {
        if (IsNearMan(pMovable, x, y)) return Cell_Man;
        if (IsNearMovingBlock(pMovable, x, y)) return Cell_MovingBlock;
        if (IsNearMonster(pMovable, x, y)) return Cell_Monster;
    }
    return cell;
}


byte NextCellOrMovable(ptr<Movable> pMovable, byte direction)
{
    ptr<sbyte> pElements;
    byte x, y, cell;
    pElements = DirectionElements + direction;
    x = (pMovable->x >> MapShift) + *pElements;
    ++pElements;
    y = (pMovable->y >> MapShift) + *pElements;
    cell = GetCellOrMovable(pMovable, x, y);
    return cell;
}


bool IsNear(ptr<Movable> p1, ptr<Movable>p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}


byte GetCellOrBlock(ptr<Movable> pMovable, byte x, byte y)
{
    byte cell;
    cell = GetCell(x, y);
    if (cell == Cell_None) {
        if (IsNearMovingBlock(pMovable, x, y)) return Cell_MovingBlock;
    }
    return cell;
}
