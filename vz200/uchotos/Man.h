#include "Movable.h"

struct ManDirection {
    byte key;
    sbyte dx, dy;
    byte pattern;
};

struct Man : Movable {
    byte status;
    sbyte dx, dy;
};

extern Man Man;
extern ptr<ManDirection> pManDirection;

extern void InitMan();
extern void ShowMan();
extern void MoveMan();
extern void HitToMan(ptr<Movable> pMovable);
