#include "Movable.h"

struct EnemyFighter {
    Movable _;
    byte type;
};


extern EnemyFighter[] EnemyFighters;

extern void InitEnemyFighters();
extern void StartEnemyFighter(byte type);
extern void MoveEnemyFighters();
extern bool HitBulletEnemyFighter(byte x, byte y);
