#include "Line.h"
#include "Chars.h"
#include "Stage.h"
#include "Vram.h"
#include "Movable.h"
#include "Actor.h"
// #include "Sound.h"
#include "Sprite.h"
#include "Item.h"
#include "Monster.h"
#include "VVram.h"

struct LineCell {
    byte[4] chars;
};

static const byte[] LeavingBytes = {
    Line_Left, Line_Right, Line_Top, Line_Bottom
};
static const byte[] EnteringBytes = {
    Line_Right, Line_Left, Line_Bottom, Line_Top
};
static const byte[] MaskBytes = {
    ~Line_Right, ~Line_Left, ~Line_Bottom, ~Line_Top
};

byte LineFirstX, LineFirstY;
byte LineLastX, LineLastY;
byte LinePrevX, LinePrevY;
bool LineRed;

extern void _deb();
byte SetLineCell(byte x, byte y, byte bits)
{
    ptr<byte> pCell;
    byte old, cell;
    pCell = CellMapPtr(x, y);
    old = *pCell;
    cell = old | bits;
    *pCell = cell;
    // Put2S(VramAddress(x << 1, (y << 1) + StatusHeight), Cells[cell].chars);
    return old;
}


void GrowLeavingLine(byte direction)
{
    SetLineCell(LineLastX, LineLastY, LeavingBytes[direction >> 1]);
}


static byte CellToDirection(byte cell)
{
    byte direction;
    direction = 0;
    repeat (4) {
        if ((cell & 1) != 0) return direction;
        direction += 2;
        cell >>= 1;
    }
}


static byte Trace(byte old, bool erase)
{
    byte x, y, mask, cell;
    ptr<byte> pCell;
    x = LineFirstX;
    y = LineFirstY;
    mask = 0xff;
    do {
        ptr<sbyte> pElements;
        byte direction;
        // word vram;
        pCell = CellMapPtr(x, y);
        cell = *pCell;
        // vram = VramAddress(x << 1, (y << 1) + StatusHeight);
        if (erase) {
            *pCell = Cell_Space;
            // Erase2(vram);
        }
        else {
            old = 0;
        }
        cell &= mask;
        direction = CellToDirection(cell);
        pElements = DirectionElements + direction;
        x += *pElements;
        ++pElements;
        y += *pElements;
        mask = MaskBytes[direction >> 1];
    } while (x != LineLastX || y != LineLastY);
    return mask;
}


void GrowEnteringLine(byte direction)
{
    byte old;
    {
        ptr<sbyte> pElements;
        pElements = DirectionElements + direction;
        LinePrevX = LineLastX;
        LinePrevY = LineLastY;
        LineLastX += *pElements;
        ++pElements;
        LineLastY += *pElements;
    }
    old = SetLineCell(LineLastX, LineLastY, EnteringBytes[direction >> 1]);
    if (old != 0) {
        byte mask, cell;
        ptr<byte> pCell;
        if (LineFirstX != LineLastX || LineFirstY != LineLastY) {
            mask = Trace(0, true);
        }
        else {
            mask = 0xff;
        }
        pCell = CellMapPtr(LineLastX, LineLastY);
        cell = *pCell & mask;
        *pCell = cell; //old & mask;
        DrawAll();
        LineFirstX = LineLastX;
        LineFirstY = LineLastY;
        Trace(cell, false);
        LineRed = true;
        DrawAll();
        // Sound_Beep();
        EraseItems();
        // WeakenMonsters();
        LineRed = false;
        Trace(0, true);
        LinePrevX = LineLastX;
        LinePrevY = LineLastY;
    }
}


bool IsSurrounded(byte x, byte y)
{
    byte xMod, yMod, topCount, bottomCount;
    ptr<byte> pCell;
    xMod = x & 1;
    yMod = y & 1;
    x >>= 1;
    y >>= 1;
    pCell = CellMapPtr(x, y);
    // if (xMod !=0 && (*pCell & Cell_Line) != 0) {
    //     ++pCell;
    // }
    // if (yMod !=0 && (*pCell & Cell_Line) != 0) {
    //     pCell += MapWidth;
    // }
    topCount = 0;
    bottomCount = 0;
    while (x < MapWidth) {
        byte cell;
        cell = *pCell;
        if ((cell & Line_Top) != 0) {
            ++topCount;
        }
        if ((cell & Line_Bottom) != 0) {
            ++bottomCount;
        }
        ++x;
        ++pCell;
    }
    return (topCount & 1) != 0 && (bottomCount & 1) != 0;
}
