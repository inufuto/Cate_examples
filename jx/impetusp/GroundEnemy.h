#include "Stage.h"
#include "Enemy.h"

struct GroundEnemy : Enemy {
    byte type;
    byte routeCount;
    byte moveCount;
    ptr<Route> pRoute;
};


extern void InitGroundEnemies();
extern void StartGroundEnemy();
extern void ScrollGroundEnemy();
extern void MoveGroundEnemy();
extern bool HitBulletGroundEnemy(byte x, byte y);
