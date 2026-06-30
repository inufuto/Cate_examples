#include "Movable.h"
#include "Stage.h"

constexpr byte HitRange = (CoordRate * 4 / 3);

void LocateMovable(ptr<Movable> pMovable, byte b)
{
    pMovable->x = ((b >> 3) & 0xfe) << CoordShift;
    pMovable->y = (b & 15) << (1 + CoordShift);
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}