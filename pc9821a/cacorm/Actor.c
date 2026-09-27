#include "Movable.h"
#include "Actor.h"

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
