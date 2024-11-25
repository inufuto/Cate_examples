#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Block.h"
#include "Sound.h"
#include "Main.h"
#include "VVram.h"

extern void _deb();

// constexpr byte Color = 15;
constexpr byte PatternMask = 0x0f;
constexpr byte Man_Pushing = 0x20;

struct Direction {
    byte key;
    sbyte dx, dy;
    byte pattern;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, 0 },
    { Keys_Right, 1, 0, 3 },
    { Keys_Up, 0, -1, 6 },
    { Keys_Down, 0, 1, 6 },
};
const byte[] ManChars = {
    0xf0, 0x00, 0x60, 0x20, 0xf0, 0x20, 0x60, 0x10,
	0xf0, 0x00, 0x50, 0x20, 0x00, 0xf0, 0x10, 0x90,
	0x10, 0xf0, 0x20, 0x90, 0x00, 0xf0, 0x10, 0xa0,
	0x70, 0xb0, 0x60, 0x90, 
};

Man Man;
static ptr<Direction> pManDirection;
static byte pushingTime;

static void Show()
{
    byte pattern = Man.status & PatternMask;;
    if ((Man.status & Movable_Fall) == 0) {
        if (Man.dy == 0) {
            if (Man.dx != 0) {
                byte seq = (Man.x >> CoordShift) & 1;
                pattern += seq + 1;
            }
        }
    }
    ShowSprite(&Man, ManChars + (pattern << 2));
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live;
    Man.dx = 0;
    Man.dy = 0;
    pManDirection = Directions + Direction_Left;
    LocateMovable(&Man, pStage->start);
    Show();
}


void MoveMan()
{
    if ((Man.status & Man_Pushing) != 0) {
        if (pushingTime >= CoordRate) {
            Man.status &= ~Man_Pushing;
        }
        else {
            ++pushingTime;
        }
    }    
    if (((Man.x | Man.y) & CoordMask) == 0) {
        sbyte dx = 0; sbyte dy = 0;
        byte pattern = Man.status & PatternMask;
        if ((Man.status & Movable_Fall) == 0) {
            byte key = ScanKeys();
            if ((key & Keys_Dir) != 0) {
                ptr<Direction> pDirection = Directions;
                repeat (4) {
                    if ((pDirection->key & key) != 0) {
                        dx = pDirection->dx;
                        dy = pDirection->dy;
                        if (CanMove(&Man, dx, dy)) {
                            pManDirection = pDirection;
                            pattern = pManDirection->pattern;
                        }
                        else {
                            if (
                                NextCell != 0 &&
                                ((Man.x | Man.y) & CellCoordMask) == 0
                            ) goto stop;
                            if (
                                CanMove(&Man, pManDirection->dx, pManDirection->dy)
                            ) {
                                dx = pManDirection->dx;
                                dy = pManDirection->dy;
                                pattern = pManDirection->pattern;
                            }
                            else {
                                stop:
                                pManDirection = pDirection;
                                if (pManDirection->dx != 0) {
                                    pattern = pManDirection->pattern;
                                }
                                dx = 0;
                                dy = 0;
                            }
                        }
                        break;
                    }
                    ++pDirection;
                }
            }
            Man.dx = dx;
            Man.dy = dy;
            Man.status = (Man.status & ~PatternMask) | pattern;
            if ((key & Keys_Button0) != 0 && (Man.status & Man_Pushing) == 0) {
                if (PushBlock(&Man, pManDirection->dx, pManDirection->dy)) {
                    Sound_Push();
                    Man.status |= Man_Pushing;
                    pushingTime = 0;
                }
            }
        }
        if (HitToBlock(&Man)) {
            Man.dx = 0;
            Man.dy = 0;
        }
    }
    MoveMovable(&Man);
    if (((Man.x | Man.y) & CellCoordMask) == 0) {
        byte column = Man.x >> CellCoordShift;
        byte row = Man.y >> CellCoordShift;
        if ((row & 1) != 0) {
                                        _deb();
            ptr<byte> pCell = CellMapPtr(column, row);
            byte b = *pCell;
            if ((b & (Cell_Item << 4)) != 0) {
                *pCell = b & ~(Cell_Item << 4);
                // DrawCellCR(column, row);
                --ItemCount;
                AddScore(5);
                Sound_Hit();
            }
        }
        if (FallMovable(&Man)) {
            Man.dy = 1;
            Man.dx = 0;
            pManDirection = Directions + Direction_Down;
        }
    }
    Show();
}


void LooseMan()
{
    static const byte[] Chars = {
        0xf0, 0x00, 0x60, 0x20,
        0x00, 0x10, 0xf0, 0x90,
	    0x40, 0x60, 0x00, 0xf0,
        0x90, 0xf0, 0x80, 0x00,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man, Chars + ((i & 3) << 2));
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
}


bool HitToMan(ptr<Movable> pMovable)
{
    byte x = pMovable->x + pMovable->dx;
    byte y = pMovable->y + pMovable->dy;
    return IsNearXY(x, y, &Man);
}