#include "Enemy.h"
#include "Stage.h"
#include "Monster.h"
#include "Ball.h"
#include "Vram.h"

bool CanMoveEnemy(word pActor, sbyte dx, sbyte dy)
{
    byte nextColumn = (ReadVram(pActor + Movable_x) >> GridCoordShift) + dx;
    if (nextColumn >= ColumnCount) return false;
    byte nextRow = (ReadVram(pActor + Movable_y) >> GridCoordShift) + dy;
    if (nextRow >= RowCount) return false;
    byte cell = GetCell(nextColumn, nextRow);
    if (cell == Cell_Wall) return false;
    return !IsBlockedByMonster(pActor, nextColumn, nextRow) && !IsBlockedByBall(pActor, nextColumn, nextRow);
}
