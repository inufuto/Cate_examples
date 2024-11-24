#include "Man.h"
#include "ScanKeys.h"
#include "Sprite.h"
#include "Stage.h"
#include "VVram.h"
#include "Destruction.h"
#include "Main.h"
#include "Sound.h"

extern void _deb();

// constexpr byte Color = 15;
constexpr byte PatternMask = 0x0f;
constexpr byte Pattern_Left = 0;
constexpr byte Pattern_Right = 3;
constexpr byte Pattern_UpDown = 6;

struct Direction {
    byte key;
    byte pattern;
    sbyte dx, dy;
};
static const Direction[] DirectionTable = {
    { Keys_Left, Pattern_Left, -1, 0 },
    { Keys_Right, Pattern_Right, 1, 0 },
    { Keys_Up, Pattern_UpDown, 0, -1 },
    { Keys_Down, Pattern_UpDown, 0, 1 },
};

Movable Man;
static ptr<Direction> pOldDirection;

const byte[] ManChars = {
    0xf0, 0x00, 0x60, 0x20, 0xf0, 0x20, 0x60, 0x10,
	0xf0, 0x00, 0x50, 0x20, 0x00, 0xf0, 0x10, 0x90,
	0x10, 0xf0, 0x20, 0x90, 0x00, 0xf0, 0x10, 0xa0,
	0x70, 0xb0, 0x60, 0x90,
};

static void Show()
{
    byte pattern;
    pattern = Man.status & PatternMask;
    if ((Man.status & Movable_Fall) == 0) {
        if (pattern != Pattern_UpDown && Man.dx != 0) {
            byte seq;
            seq = (Man.x >> CoordShift) & 1;
            pattern += seq + 1;
        }
    }
    ShowSprite(&Man, ManChars + (pattern << 2));
}


void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live | Pattern_Left;
    Man.dx = 0;
    Man.dy = 0;
    pOldDirection = DirectionTable;
    LocateMovable(&Man, pStage->start);
    Show();
}


void FallMan()
{
    if ((Man.status & Movable_Fall) != 0) {
        if (((Man.x | Man.y) & CoordMask) == 0) {
            if (FallMovable(&Man)) { //  && CanMove(&Man, Man.dx, 1)
                Man.dy = 1;
                Man.dx = 0;
            }
        }
        MoveMovable(&Man);
        Show();
    }
}


void MoveMan()
{
    if (((Man.x | Man.y) & CoordMask) == 0) {
        sbyte dx, dy;
        byte pattern;
        dx = 0; dy = 0;
        pattern = Man.status & PatternMask;
        if ((Man.status & Movable_Fall) == 0) {
            byte key;
            ptr<Direction> pDirection;
            key = ScanKeys();
            pDirection = DirectionTable;
            repeat (4) {
                if ((pDirection->key & key) != 0) {
                    dx = pDirection->dx;
                    dy = pDirection->dy;
                    pattern = pDirection->pattern;
                    if (CanMove(&Man, dx, dy)) {
                        pOldDirection = pDirection;
                    }
                    else {
                        if (CanMove(&Man, pOldDirection->dx, pOldDirection->dy)) {
                            dx = pOldDirection->dx;
                            dy = pOldDirection->dy;
                            pattern = pOldDirection->pattern;
                        }
                        else {
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
    }
    MoveMovable(&Man);
    Show();
    if (((Man.x | Man.y) & CoordMask) == 0) {
        byte x, y;
        x = Man.x >> CoordShift;
        y = Man.y >> CoordShift;
        if ((x & ColumnMask) == 0 && (y & FloorMask) == 1) {
            byte column, floor, cell;
            column = x >> ColumnShift;
            floor = y >> FloorShift;
            cell = GetCell(column, floor);
            if ((cell & Cell_LowerMask) == Cell_CrackedFloor) {
                StartDestruction(column, floor);
                AddScore(1);
            }
            else if ((cell & Cell_UpperMask) == Cell_Item) {
                ptr<byte> pVVram;
                SetCell(column, floor, cell & Cell_LowerMask);
                --ItemCount;
                AddScore(5);
                Sound_Hit();
            }
        }
        FallMovable(&Man);
    }
}


void LooseMan()
{
    static const byte[] Chars = {
        0xf0, 0x00, 0x60, 0x20,0x00, 0x10, 0xf0, 0x90,
	    0x40, 0x60, 0x00, 0xf0, 0x90, 0xf0, 0x80, 0x00,
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
