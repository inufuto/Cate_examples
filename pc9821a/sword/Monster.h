#include "Movable.h"

struct Monster : Actor {
    byte startX, startY;
    byte count;
};

extern Monster[] Monsters;

extern void InitMonsters();
extern void MoveMonsters();
extern bool IsBlockedByMonster(ptr<Actor> pActor, byte column, byte row);
extern void HitMonsters(byte x, byte y);