#include "Movable.h"
#include "Sprite.h"
#include "Stage.h"
#include "Direction.h"

constexpr byte Size = 2 << CoordShift;
constexpr byte HitRange = Size - 1; //Size / 2;
constexpr byte ShortRange = Size * 1 / 2;

byte MovableX(byte b)
{
    return ((b >> 3) & 0xfe) << CoordShift;
}

byte MovableY(byte b)
{
    return (((b & 15) << 1) + 2) << CoordShift;
}


void SetDirection(ptr<Movable> pMovable, byte direction)
{
    ptr<sbyte> pDirection;
    pDirection = DirectionPtr(direction);
    pMovable->dx = *pDirection;
    ++pDirection;
    pMovable->dy = *pDirection;
    pMovable->status = (pMovable->status & ~Movable_Direction_Mask) | direction;
}


bool CanChangeDirection(ptr<Movable> pMovable)
{
    return ((pMovable->x | pMovable->y) & MapMask) == 0;
}


bool MoveMovable(ptr<Movable> pMovable)
{
    if ((pMovable->status & Movable_Status_CanMove) != 0) {
        pMovable->x += pMovable->dx;
        pMovable->y += pMovable->dy;
        return true;
    }
    return false;
}


// bool IsNearXYXY(byte x1, byte y1, byte x2, byte y2)
// {
//     return
//         x1 + HitRange >= x2 && x2 + HitRange >= x1 &&
//         y1 + HitRange >= y2 && y2 + HitRange >= y1;
// }

bool IsNearXY(ptr<Movable> pMovable, byte x, byte y)
{
    // return IsNearXYXY(pMovable->x, pMovable->y, x, y);
    return
        pMovable->x + HitRange >= x && x + HitRange >= pMovable->x &&
        pMovable->y + HitRange >= y && y + HitRange >= pMovable->y;
}

bool IsNear(ptr<Movable> p1, ptr<Movable>p2)
{
    return IsNearXY(p1, p2->x, p2->y);
}

bool IsVeryNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + ShortRange >= p2->x && p2->x + ShortRange >= p1->x &&
        p1->y + ShortRange >= p2->y && p2->y + ShortRange >= p1->y;
}

bool IsOnGrid(ptr<Movable> pMovable)
{
    return ((pMovable->x + pMovable->y) & CoordMask) == 0;
}