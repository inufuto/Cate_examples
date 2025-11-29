#include "Enemy.h"

bool HitEnemy(ptr<Enemy> pEnemy, byte x, byte y)
{
    return
        x + CoordRate / 2 >= pEnemy->x && pEnemy->x + CoordRate * 4 / 2 >= x &&
        y + CoordRate / 2 >= pEnemy->y && pEnemy->y + CoordRate * 4 / 2 >= y;
}
