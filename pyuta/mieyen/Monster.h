#include "Movable.h"

// struct Monster : Movable {
//     byte targetX, targetY;
// };
constexpr byte Monster_targetX = 6;
constexpr byte Monster_targetY = 7;
constexpr byte Monster_unitSize = 8;

// extern Monster[] Monsters;
extern byte MonsterCount;

extern void InitMonsters();
extern void StartMonsters();
extern void MoveMonsters();
extern word HitMonster(word pMovable);
