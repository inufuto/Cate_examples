#include "Enemy.h"

bool HitEnemy(ptr<Enemy> pEnemy, byte x, byte y)
{
    return
        x >= pEnemy->x && x < pEnemy->x + CoordRate * 2 &&
        y >= pEnemy->y && y < pEnemy->y + CoordRate * 2;
}
