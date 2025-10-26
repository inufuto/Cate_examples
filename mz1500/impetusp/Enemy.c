#include "Enemy.h"

bool HitEnemy(ptr<Enemy> pEnemy, byte x, byte y)
{
    return
        x + 1 >= pEnemy->x && pEnemy->x + 1 >= x &&
        y + 1 >= pEnemy->y && pEnemy->y + 1 >= y;
}
