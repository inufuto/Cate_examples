#include "Movable.h"

struct Monster : Movable {};

extern Monster[] Monsters;

extern void InitMonsters();
extern void MoveMonsters();
extern bool HitMonster(ptr<Movable> pMovable);