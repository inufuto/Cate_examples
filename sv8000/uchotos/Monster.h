#include "Movable.h"

struct Monster : Movable {
    byte status;
    sbyte dx, dy;
    byte startX, startY;
    byte count;
};

extern Monster[] Monsters;

extern void InitMonsters();
extern void MoveMonsters();
extern ptr<Monster> HitMonster(ptr<Movable> pFire);
