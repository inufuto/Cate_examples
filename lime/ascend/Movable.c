#include "Movable.h"

bool IsNear(byte a, byte b)
{
    return (a - b) + 1 < 3;
}


bool IsNearXY(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        (p1->x - p2->x) + 1 < 2 &&
        (p1->y - p2->y) + 1 < 2;
}
