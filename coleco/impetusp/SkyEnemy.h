#include "Enemy.h"

struct SkyEnemy : Enemy {
    byte type;
    byte pattern;
    byte bulletCount;
    byte direction;
};

extern void InitSkyEnemies();
extern void StartSkyEnemy();
extern void MoveSkyEnemies();
extern bool HitBulletSkyEnemy(byte x, byte y);
