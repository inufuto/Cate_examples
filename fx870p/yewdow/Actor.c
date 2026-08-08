#include "Movable.h"
#include "Actor.h"
#include "Stage.h"

const sbyte[] DirectionElements = {
    -1, 0,
    1,0,
    0,-1,
    0,1,
};


void SetDirection(ptr<Actor> pActor, byte direction)
{
    ptr<sbyte> pElements;
    pActor->status = (pActor->status & ~Actor_DirectionMask) | direction;
    pElements = DirectionElements + direction;
    pActor->dx = *pElements;
    ++pElements;
    pActor->dy = *pElements;
}


bool CanMove(ptr<Actor> pActor, byte direction)
{
    ptr<sbyte> pElements;
    byte x,y;
    sbyte dx, dy;
    byte cell;
    pElements = DirectionElements + direction;
    dx = *pElements;
    ++pElements;
    dy = *pElements;
    x = (pActor->_.x >> MapShift) + dx;
    y = (pActor->_.y >> MapShift) + dy;
    return CanMoveTo(x, y);
}


void Move(ptr<Actor> pActor)
{
    byte seq;
    pActor->_.x += pActor->dx;
    pActor->_.y += pActor->dy;
    seq = ((pActor->_.x + pActor->_.y + CoordRate / 2) >> CoordShift) & 1;
    pActor->status = (pActor->status & ~Actor_SeqMask) | seq;
}
