#include "Line.h"
#include "Chars.h"
#include "Stage.h"
#include "Vram.h"
#include "Movable.h"
#include "Actor.h"
#include "Sound.h"
#include "Sprite.h"
#include "Item.h"
#include "Monster.h"

extern void _deb();

struct LineCell {
    byte[4] chars;
};

static const LineCell[] Cells = {
    {{ Char_Space, Char_Space, Char_Space, Char_Space }}, // none
    {{ Char_Line_Bottom, Char_Space, Char_Line_Top, Char_Space }}, // left
    {{ Char_Space, Char_Line_Bottom, Char_Space, Char_Line_Top }}, // right
    {{ Char_Line_Bottom, Char_Line_Bottom, Char_Line_Top, Char_Line_Top }}, // left right
    {{ Char_Line_Right, Char_Line_Left, Char_Space, Char_Space }}, // top
    {{ Char_Line_RightBottom, Char_Line_Left, Char_Line_Top, Char_Space }}, // top left
    {{ Char_Line_Right, Char_Line_LeftBottom, Char_Space, Char_Line_Top }}, // top right
    {{ Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_Top, Char_Line_Top }}, // top left right
    {{ Char_Space, Char_Space, Char_Line_Right, Char_Line_Left }}, // bottom
    {{ Char_Line_Bottom, Char_Space, Char_Line_RightTop, Char_Line_Left }}, // bottom left
    {{ Char_Space, Char_Line_Bottom, Char_Line_Right, Char_Line_LeftTop }}, // bottom right
    {{ Char_Line_Bottom, Char_Line_Bottom, Char_Line_RightTop, Char_Line_LeftTop }}, // bottom left right
    {{ Char_Line_Right, Char_Line_Left, Char_Line_Right, Char_Line_Left }}, // bottom top
    {{ Char_Line_RightBottom, Char_Line_Left, Char_Line_RightTop, Char_Line_Left }}, // bottom top left
    {{ Char_Line_Right, Char_Line_LeftBottom, Char_Line_Right, Char_Line_LeftTop }}, // bottom top right
    {{ Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_RightTop, Char_Line_LeftTop }}, // bottom top left right
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
byte LineCharOffset;

byte SetLineCell(byte x, byte y, byte bits)
{
    ptr<byte> pCell;
    byte old, cell;
    pCell = CellMapPtr(x, y);
    old = *pCell;
    cell = old | bits;
    SetCell(x, y, cell);
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
    byte x = LineFirstX;
    byte y = LineFirstY;
    byte mask = 0xff;
    do {
        ptr<sbyte> pElements;
        byte direction;
        ptr<byte> pCell = CellMapPtr(x, y);
        byte cell = *pCell;
        if (erase) {
            SetCell(x, y, Cell_Space);
        }
        else {
            DrawLineCell(VramAddress(x << 1, (y << 1) + StageTop), cell);
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
        LineFirstX = LineLastX;
        LineFirstY = LineLastY;
        LineCharOffset = Char_Line_Bold - Char_Line_Normal;
        Trace(cell, false);
        DrawAll();
        Sound_Beep();
        EraseItems();
        LineCharOffset = 0;
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


word DrawLineCell(word vram, byte cell)
{
    ptr<byte> pChars = Cells[cell].chars;
    repeat (2) {
        repeat (2) {
            byte c = *pChars;
            ++pChars;
            if (c != Char_Space) {
                c += LineCharOffset;
            }
            vram = VAdd(vram, c);
        }
        vram += VramRowSize - CellSize;
    }
    return vram - VramRowSize * CellSize + CellSize;
}