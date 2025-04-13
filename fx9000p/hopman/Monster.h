#include "Movable.h"

struct Monster {
    Movable _;
    byte left, right;
    sbyte dx;
    byte pattern;
};

extern void InitMonsters();
extern void MoveMonsters();
