#include "Movable.h"
#include "Stage.h"
#include "Sprite.h"

extern void _deb();

constexpr byte HitRange = (CoordRate * 4 / 3);

const Direction[] Directions = {
    { -1, 0, Direction_Left * 2 },
    { 1, 0, Direction_Right * 2 },
    { 0, -1, Direction_Up * 2 },
    { 0, 1, Direction_Down * 2 },
};


void LocateMovable(ptr<Movable> pMovable, byte b)
{
    byte column = b >> 4;
    byte row = b & 0x0f;
    pMovable->x = ToCoord(column) << CoordShift;
    pMovable->y = ToCoord(row) << CoordShift;
}


void ShowMovable(ptr<Movable> pMovable, byte pattern, byte color)
{
    pattern += pMovable->status & Movable_Pattern;
    byte seq = ((pMovable->x + pMovable->y) >> CoordShift) & 1;
    pattern += seq;
    ShowSprite(pMovable, pattern, color);
}


void SetDirection(ptr<Movable> pMovable, ptr<Direction> pDirection)
{
    pMovable->dx = pDirection->dx;
    pMovable->dy = pDirection->dy;
    pMovable->status = (pMovable->status & ~Movable_Pattern) | pDirection->pattern;
}


bool CanMove(ptr<Movable> pMovable, sbyte dx, sbyte dy)
{
    byte x = pMovable->x;
    byte y = pMovable->y;
    if (dy == 0) {
        byte yMod = CoordMod(y);
        if (yMod != 0) return false;
        byte xMod = CoordMod(x);
        if (dx < 0) {
            if (xMod == 0) {
                byte column = ToGrid(x);
                if (column == 0) {
                    return false;
                }
                byte row = ToGrid(y);
                if ((GetCell(column - 1, row) & Cell_RightWall) != 0) {
                    return false;
                }
            }
            return true;
        }
        else {
            if (xMod == 0) {
                byte column = ToGrid(x);
                if (column >= ColumnCount - 1) {
                    return false;
                }
                byte row = ToGrid(y);
                if ((GetCell(column, row) & Cell_RightWall) != 0) {
                    return false;
                }
            }
            return true;
        }
    }
    else if (dx == 0) {
        byte xMod = CoordMod(x);
        if (xMod != 0) return false;
        byte yMod = CoordMod(y);
        if (dy < 0) {
            if (yMod == 0) {
                byte row = ToGrid(y);
                if (row == 0) {
                    return false;
                }
                byte column = ToGrid(x);
                if ((GetCell(column, row - 1) & Cell_BottomWall) != 0) {
                    return false;
                }
            }
            return true;
        }
        else {
            if (yMod == 0) {
                byte row = ToGrid(y);
                if (row >= RowCount - 1) {
                    return false;
                }
                byte column = ToGrid(x);
                if ((GetCell(column, row) & Cell_BottomWall) != 0) {
                    return false;
                }
            }
            return true;
        }
    }
}


void MoveMovable(ptr<Movable> pMovable)
{
    pMovable->x += pMovable->dx;
    pMovable->y += pMovable->dy;
}


bool IsOnGrid(ptr<Movable> pMovable)
{
    if (((pMovable->x | pMovable->y) & CoordMask) != 0) return false;
    if (CoordMod(pMovable->x) != 0) return false;
    if (CoordMod(pMovable->y) != 0) return false;
    return true;
}


bool IsNear(ptr<Movable> p1, ptr<Movable> p2)
{
    return
        p1->x + HitRange >= p2->x && p2->x + HitRange >= p1->x &&
        p1->y + HitRange >= p2->y && p2->y + HitRange >= p1->y;
}
