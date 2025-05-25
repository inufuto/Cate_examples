#include "Movable.h"

constexpr byte Monster_unitSize = Movable_unitSize;

// struct Monster : Movable {
// };

// extern Monster[] Monsters;

extern void InitMonsters();
extern void ShowMonsters();
extern void MoveMonsters();
extern bool HitMonsters(word pKnife);
