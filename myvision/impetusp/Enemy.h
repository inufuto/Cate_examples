#include "Movable.h"

struct Enemy : Movable {
    sbyte dx, dy;
    byte clock;
};

extern bool HitEnemy(ptr<Enemy> pEnemy, byte x, byte y);
