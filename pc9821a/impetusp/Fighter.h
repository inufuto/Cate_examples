#include "Movable.h"

struct Fighter : Movable {
    byte crashCount;
    byte reviveCount;
};

extern Fighter Fighter;

extern void InitFighter();
extern void MoveFighter();
extern bool HitBulletFighter(byte x, byte y);
extern bool HitEnemyFighter(byte x, byte y);
