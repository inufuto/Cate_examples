#include "Mover.h"

bool HitMover(byte x1, byte y1, byte size1, byte x2, byte y2, byte size2)
{
    byte xDiff, yDiff;
    byte minDistance, minDistance2;
    minDistance = size1 + size2;
    xDiff = x2 - x1 + minDistance;
    yDiff = y2 - y1 + minDistance;
    minDistance2 = (minDistance << 1) + 1;
    return xDiff < minDistance2 &&  yDiff < minDistance2;
}