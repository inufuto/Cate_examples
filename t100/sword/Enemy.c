#include "Enemy.h"
#include "Stage.h"
#include "Monster.h"
#include "Ball.h"

bool CanMoveEnemy(ptr<Actor> pActor, sbyte dx, sbyte dy)
{
    byte nextColumn = (pActor->x >> GridCoordShift) + dx;
    if (nextColumn >= ColumnCount) return false;
    byte nextRow = (pActor->y >> GridCoordShift) + dy;
    if (nextRow >= RowCount) return false;
    byte cell = GetCell(nextColumn, nextRow);
    if (cell == Cell_Wall) return false;
    return !IsBlockedByMonster(pActor, nextColumn, nextRow) && !IsBlockedByBall(pActor, nextColumn, nextRow);
}
