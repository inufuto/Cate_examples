#include "Enemy.h"
#include "Coord.h"

byte EnemyCount;

bool HitBulletEnemy(byte bulletX, byte bulletY, byte enemyX, byte enemyY)
{
    return
        bulletX + CoordRate >= enemyX &&
        enemyX + CoordRate >= bulletX &&
        bulletY + CoordRate * 3 / 4 >= enemyY &&
        enemyY + CoordRate * 7 / 4 >= bulletY;
}
