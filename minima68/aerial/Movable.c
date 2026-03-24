#include "Movable.h"

constexpr byte HitRange = (CoordRate * 3 / 2);

void LocateMovableB(ptr<Movable> pMovable, byte b)
{
    pMovable->x = ((b >> 3) & 0xfe) << CoordShift;
    pMovable->y = ((b & 15) << 1) << CoordShift;
}


bool IsOnGrid(ptr<Movable> pMovable)
{
    return ((pMovable->x | pMovable->y) & MapMask) == 0;
}


// byte GetCellOrMovable(ptr<Movable> pMovable, byte x, byte y)
// {
//     byte cell;
//     cell = GetCell(x, y);
//     if (cell == Cell_None) {
//         if (IsNearMan(pMovable, x, y)) return Cell_Man;
//         if (IsNearMovingBlock(pMovable, x, y)) return Cell_MovingBlock;
//         if (IsNearMonster(pMovable, x, y)) return Cell_Monster;
//     }
//     return cell;
// }


// byte NextCellOrMovable(ptr<Movable> pMovable, byte direction)
// {
//     ptr<sbyte> pElements;
//     byte x, y, cell;
//     pElements = DirectionElements + direction;
//     x = (pMovable->x >> MapShift) + *pElements;
//     ++pElements;
//     y = (pMovable->y >> MapShift) + *pElements;
//     cell = GetCellOrMovable(pMovable, x, y);
//     return cell;
// }


bool IsNear(ptr<Movable> p1, ptr<Movable>p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}


// byte GetCellOrBlock(ptr<Movable> pMovable, byte x, byte y)
// {
//     byte cell;
//     cell = GetCell(x, y);
//     if (cell == Cell_None) {
//         if (IsNearMovingBlock(pMovable, x, y)) return Cell_MovingBlock;
//     }
//     return cell;
// }
