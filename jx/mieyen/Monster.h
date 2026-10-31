#include "Actor.h"

struct Monster {
    Actor _;
    byte startX, startY;
};

extern Monster[] Monsters;

extern void InitMonsters();
extern void MoveMonsters();
extern void HitCarMonsters(ptr<Movable> pMovable);
extern void HitManMonsters();