#include "Enemy.h"

struct EnemyBullet {
    byte x, y;
    sbyte dx, dy;
    byte code;
    byte sprite;
    sbyte numeratorX, denominatorX;
    sbyte numeratorY, denominatorY;
};

extern void InitEnemyBullets();
extern bool StartEnemyBullet(ptr<Enemy> pEnemy);
extern void MoveEnemyBullets();