#include "Movable.h"

struct Monster : Actor {
};

extern Monster[] Monsters;

extern void InitMonsters();
extern void MoveMonsters();
extern bool HitMonster(ptr<Movable> pMovable);
extern void HitMonsters();