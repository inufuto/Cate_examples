#include "Movable.h"

constexpr byte MonsterColor = 15;

constexpr byte Monster_startX = 6;
constexpr byte Monster_startY = 7;
constexpr byte Monster_count = 8;
constexpr byte Monster_unitSize = 9;

// struct Monster : Actor {
//     byte startX, startY;
//     byte count;
// };

// extern Monster[] Monsters;

extern void InitMonsters();
extern void MoveMonsters();
extern bool IsBlockedByMonster(word pActor, byte column, byte row);
extern void HitMonsters(byte x, byte y);