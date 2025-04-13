#include "Movable.h"

struct Lift {
    Movable _;
    byte leftTop;
    byte rightBottom;
    sbyte dx, dy;
    byte pattern;
};

extern void InitLifts();
extern void MoveLifts();
extern bool IsManOnAnyLift();
extern ptr<Lift> FindLift(ptr<Movable> pMovable, byte nextY);
