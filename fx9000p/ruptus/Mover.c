#include "Mover.h"

bool HitMover(byte x1, byte y1, byte size1, byte x2, byte y2, byte size2)
{
    byte xDiff, yDiff, range;
    if (size2 != 0) {
        if (size1 != 0) {
            byte minDistance;
            minDistance = size1 + size2 - 1;
            xDiff = x2 - x1 + minDistance;
            yDiff = y2 - y1 + minDistance;
            range = (minDistance << 1) + 1;
        }
        else {
            xDiff = x1 - x2 + size2;
            yDiff = y1 - y2 + size2;
            range = (size2 << 1);
        }
    }
    else {
        if (size1 != 0) {
            xDiff = x2 - x1 + size1;
            yDiff = y2 - y1 + size1;
            range = (size1 << 1);
        }
        else {
            return x1 == x2 && y1 == y2;
        }
    }
    return xDiff < range &&  yDiff < range;
}
