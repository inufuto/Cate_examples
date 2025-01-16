#include "Movable.h"
#include "Stage.h"
#include "Sprite.h"
#include "Vram.h"

extern void _deb();

constexpr byte HitRange = (CoordRate * 4 / 3);

const Direction[] Directions = {
    { -1, 0, Direction_Left * 2 },
    { 1, 0, Direction_Right * 2 },
    { 0, -1, Direction_Up * 2 },
    { 0, 1, Direction_Down * 2 },
};


void LocateMovable(word pMovable, byte b)
{
    byte column = b >> 4;
    byte row = b & 0x0f;
    WriteVram(pMovable + Movable_x, ToCoord(column) << CoordShift);
    WriteVram(pMovable + Movable_y, ToCoord(row) << CoordShift);
}


void ShowMovable(word pMovable, byte pattern, byte color)
{
    pattern += ReadVram(pMovable + Movable_status) & Movable_Pattern;
    byte seq = ((ReadVram(pMovable + Movable_x) + ReadVram(pMovable + Movable_y)) >> CoordShift) & 1;
    pattern += seq;
    ShowSprite(pMovable, pattern, color);
}


void SetDirection(word pMovable, ptr<Direction> pDirection)
{
    WriteVram(pMovable + Movable_dx, pDirection->dx);
    WriteVram(pMovable + Movable_dy, pDirection->dy);
    WriteVram(pMovable + Movable_status, (ReadVram(pMovable + Movable_status) & ~Movable_Pattern) | pDirection->pattern);
}


bool CanMove(word pMovable, sbyte dx, sbyte dy)
{
    byte x = ReadVram(pMovable + Movable_x);
    byte y = ReadVram(pMovable + Movable_y);
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


void MoveMovable(word pMovable)
{
    byte x = ReadVram(pMovable + Movable_x);
    x += ReadVram(pMovable + Movable_dx);
    WriteVram(pMovable + Movable_x, x);
    byte y = ReadVram(pMovable + Movable_y);
    y += ReadVram(pMovable + Movable_dy);
    WriteVram(pMovable + Movable_y, y);
}


bool IsOnGrid(word pMovable)
{
    byte x = ReadVram(pMovable + Movable_x);
    byte y = ReadVram(pMovable + Movable_y);
    if (((x | y) & CoordMask) != 0) return false;
    if (CoordMod(x) != 0) return false;
    if (CoordMod(y) != 0) return false;
    return true;
}


bool IsNear(word p1, word p2)
{
    byte x1 = ReadVram(p1 + Movable_x);
    byte x2 = ReadVram(p2 + Movable_x);
    byte y1 = ReadVram(p1 + Movable_y);
    byte y2 = ReadVram(p2 + Movable_y);
    return
        x1 + HitRange >= x2 && x2 + HitRange >= x1 &&
        y1 + HitRange >= y2 && y2 + HitRange >= y1;
}
