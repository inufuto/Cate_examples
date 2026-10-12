#include "Movable.h"
#include "Stage.h"
#include "Actor.h"
#include "Lift.h"

constexpr byte HitRange = CoordRate;

bool IsOnGrid(ptr<Movable> pMovable)
{
    return (pMovable->x & MapMask) == 0;
}


bool IsNear(ptr<Movable> p1, ptr<Movable>p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}
