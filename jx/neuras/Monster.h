#include "Stage.h"

constexpr byte Monster_Status_None = 0;
constexpr byte Monster_Status_Normal = 1;
constexpr byte Monster_Status_Stop = 2;

struct MonsterDirection {
    sbyte dx, dy;
    sbyte pattern;
};

struct Monster {
    byte status;
    byte x, y;
    byte stopCount;
    ptr<MonsterDirection> pDirection;
};

constexpr byte MonsterCount = 4;

extern Monster[] Monsters;

extern void InitMonsters(ptr<byte> pPosition, byte count);
extern void MoveMonsters();
extern bool Monster_TestHit(byte x, byte y);
