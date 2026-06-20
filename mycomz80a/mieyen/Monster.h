#include "Movable.h"

struct Monster : Movable {
    byte targetX, targetY;
};

extern Monster[] Monsters;
extern byte MonsterCount;

extern void InitMonsters();
extern void StartMonsters();
extern void MoveMonsters();
extern ptr<Monster> HitMonster(ptr<Movable> pMovable);
