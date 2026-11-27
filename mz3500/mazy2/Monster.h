#include "Movable.h"

struct Monster : Movable {
};

extern Monster[] Monsters;

extern void InitMonsters();
extern void ShowMonsters();
extern void MoveMonsters();
extern bool HitMonsters(ptr<Movable> pKnife);
