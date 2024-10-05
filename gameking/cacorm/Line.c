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

struct LineCell {
    byte[4] chars;
};
constexpr byte Char_Line_Normal_RightBottom = 0x28;
constexpr byte Char_Line_Normal_LeftBottom =  0x08;
constexpr byte Char_Line_Normal_RightTop =  0x20;
constexpr byte Char_Line_Normal_LeftTop =  0x28;
constexpr byte Char_Line_Normal_Left =  0x08;
constexpr byte Char_Line_Normal_Right =  0x20;
constexpr byte Char_Line_Normal_Top =  0x20;
constexpr byte Char_Line_Normal_Bottom =  0x08;
constexpr byte Char_Line_Bold_RightBottom = 0x3f;
constexpr byte Char_Line_Bold_LeftBottom =  0xcf;
constexpr byte Char_Line_Bold_RightTop =  0xf3;
constexpr byte Char_Line_Bold_LeftTop =  0xfc;
constexpr byte Char_Line_Bold_Left =  0xcc;
constexpr byte Char_Line_Bold_Right =  0x33;
constexpr byte Char_Line_Bold_Top =  0xf0;
constexpr byte Char_Line_Bold_Bottom =  0x0f;
static const LineCell[] NormalCells = {
    {{ Char_Space, Char_Space, Char_Space, Char_Space }}, // none
    {{ Char_Line_Normal_Bottom, Char_Space, Char_Line_Normal_Top, Char_Space }}, // left
    {{ Char_Space, Char_Line_Normal_Bottom, Char_Space, Char_Line_Normal_Top }}, // right
    {{ Char_Line_Normal_Bottom, Char_Line_Normal_Bottom, Char_Line_Normal_Top, Char_Line_Normal_Top }}, // left right
    {{ Char_Line_Normal_Right, Char_Line_Normal_Left, Char_Space, Char_Space }}, // top
    {{ Char_Line_Normal_RightBottom, Char_Line_Normal_Left, Char_Line_Normal_Top, Char_Space }}, // top left
    {{ Char_Line_Normal_Right, Char_Line_Normal_LeftBottom, Char_Space, Char_Line_Normal_Top }}, // top right
    {{ Char_Line_Normal_RightBottom, Char_Line_Normal_LeftBottom, Char_Line_Normal_Top, Char_Line_Normal_Top }}, // top left right
    {{ Char_Space, Char_Space, Char_Line_Normal_Right, Char_Line_Normal_Left }}, // bottom
    {{ Char_Line_Normal_Bottom, Char_Space, Char_Line_Normal_RightTop, Char_Line_Normal_Left }}, // bottom left
    {{ Char_Space, Char_Line_Normal_Bottom, Char_Line_Normal_Right, Char_Line_Normal_LeftTop }}, // bottom right
    {{ Char_Line_Normal_Bottom, Char_Line_Normal_Bottom, Char_Line_Normal_RightTop, Char_Line_Normal_LeftTop }}, // bottom left right
    {{ Char_Line_Normal_Right, Char_Line_Normal_Left, Char_Line_Normal_Right, Char_Line_Normal_Left }}, // bottom top
    {{ Char_Line_Normal_RightBottom, Char_Line_Normal_Left, Char_Line_Normal_RightTop, Char_Line_Normal_Left }}, // bottom top left
    {{ Char_Line_Normal_Right, Char_Line_Normal_LeftBottom, Char_Line_Normal_Right, Char_Line_Normal_LeftTop }}, // bottom top right
    // {{ Char_Line_Normal_RightBottom, Char_Line_Normal_LeftBottom, Char_Line_Normal_RightTop, Char_Line_Normal_LeftTop }}, // bottom top left right
};
static const LineCell[] BoldCells = {
    {{ Char_Space, Char_Space, Char_Space, Char_Space }}, // none
    {{ Char_Line_Bold_Bottom, Char_Space, Char_Line_Bold_Top, Char_Space }}, // left
    {{ Char_Space, Char_Line_Bold_Bottom, Char_Space, Char_Line_Bold_Top }}, // right
    {{ Char_Line_Bold_Bottom, Char_Line_Bold_Bottom, Char_Line_Bold_Top, Char_Line_Bold_Top }}, // left right
    {{ Char_Line_Bold_Right, Char_Line_Bold_Left, Char_Space, Char_Space }}, // top
    {{ Char_Line_Bold_RightBottom, Char_Line_Bold_Left, Char_Line_Bold_Top, Char_Space }}, // top left
    {{ Char_Line_Bold_Right, Char_Line_Bold_LeftBottom, Char_Space, Char_Line_Bold_Top }}, // top right
    {{ Char_Line_Bold_RightBottom, Char_Line_Bold_LeftBottom, Char_Line_Bold_Top, Char_Line_Bold_Top }}, // top left right
    {{ Char_Space, Char_Space, Char_Line_Bold_Right, Char_Line_Bold_Left }}, // bottom
    {{ Char_Line_Bold_Bottom, Char_Space, Char_Line_Bold_RightTop, Char_Line_Bold_Left }}, // bottom left
    {{ Char_Space, Char_Line_Bold_Bottom, Char_Line_Bold_Right, Char_Line_Bold_LeftTop }}, // bottom right
    {{ Char_Line_Bold_Bottom, Char_Line_Bold_Bottom, Char_Line_Bold_RightTop, Char_Line_Bold_LeftTop }}, // bottom left right
    {{ Char_Line_Bold_Right, Char_Line_Bold_Left, Char_Line_Bold_Right, Char_Line_Bold_Left }}, // bottom top
    {{ Char_Line_Bold_RightBottom, Char_Line_Bold_Left, Char_Line_Bold_RightTop, Char_Line_Bold_Left }}, // bottom top left
    {{ Char_Line_Bold_Right, Char_Line_Bold_LeftBottom, Char_Line_Bold_Right, Char_Line_Bold_LeftTop }}, // bottom top right
    // {{ Char_Line_Bold_RightBottom, Char_Line_Bold_LeftBottom, Char_Line_Bold_RightTop, Char_Line_Bold_LeftTop }}, // bottom top left right
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

extern void _deb();
byte SetLineCell(byte x, byte y, byte bits)
{
    ptr<byte> pCell;
    byte old, cell;
    pCell = CellMapPtr(x, y);
    old = *pCell;
    cell = old | bits;
    *pCell = cell;
    Put2S(Vram + VramOffset(x << 1, (y << 1) + StageTop), NormalCells[cell].chars, false);
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
        ptr<byte> pCell = CellMapPtr(x, y);
        byte cell = *pCell;
        ptr<byte> pVram = Vram + VramOffset(x << 1, (y << 1) + StageTop);
        if (erase) {
            *pCell = Cell_Space;
            Erase2(pVram, false);
        }
        else {
            Put2S(pVram, BoldCells[cell | old].chars, false);
            old = 0;
        }
        cell &= mask;
        byte direction = CellToDirection(cell);
        ptr<sbyte> pElements = DirectionElements + direction;
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
                                    // PrintByteNumber3(Vram, old);
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
        Trace(cell, false);
        Sound_Beep();
        EraseItems();
        // WeakenMonsters();
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
