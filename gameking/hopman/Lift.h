#include "Movable.h"

struct Lift {
    Movable _;
    byte leftTop;
    byte rightBottom;
    sbyte dx, dy;
};

extern void InitLifts();
extern void ShowLifts();
// extern bool IsOnLift(ptr<Movable> pMovable, ptr<Movable> pLift);
extern void MoveLifts();
extern bool IsManOnAnyLift();
extern ptr<Lift> FindLift(ptr<Movable> pMovable, byte nextY);
// extern bool MoveOnLift(ptr<Movable> pMovable, ptr<Lift> pLift);
