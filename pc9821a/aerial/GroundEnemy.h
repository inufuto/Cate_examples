#include "Movable.h"

struct GroundEnemy {
    Movable _;
    byte type;
};


extern GroundEnemy[] GroundEnemies;

extern void InitGroundEnemies();
extern void StartGroundEnemy(byte y, byte type);
extern void ScrollGroundEnemies();
extern void MoveGroundEnemies();
extern bool HitBulletGroundEnemy(byte x, byte y);
