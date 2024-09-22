#include "Stage.h"

struct GroundEnemy {
    byte x, y;
    byte sprite;
    byte type;
    byte routeCount;
    ptr<Route> pRoute;
    sbyte dx, dy;
    byte moveCount;
    byte clock;
};

extern GroundEnemy[] GroundEnemies;

extern void InitGroundEnemies();
extern void StartGroundEnemy();
extern void ScrollGroundEnemy();
extern void MoveGroundEnemy();
extern bool HitBulletGroundEnemy(byte x, byte y);
