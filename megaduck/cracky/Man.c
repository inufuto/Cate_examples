#include "Man.h"
#include "ScanKeys.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Vram.h"
#include "Destruction.h"
#include "Main.h"
#include "Sound.h"

extern void _deb();

constexpr byte PatternMask = 0x0f;

struct Direction {
    byte key;
    byte pattern;
    sbyte dx, dy;
};
static const Direction[] DirectionTable = {
    { Keys_Left, Pattern_Man_Left, -1, 0 },
    { Keys_Right, Pattern_Man_Right, 1, 0 },
    { Keys_Up, Pattern_Man_UpDown, 0, -1 },
    { Keys_Down, Pattern_Man_UpDown, 0, 1 },
};

Movable Man;
static ptr<Direction> pOldDirection;

static void Show()
{
    static const byte[] ScrollPositions = {
        0,1,1,2,3,4,4,5,6,7,7,8,9,9,10,11,12,12,13,14,15,15,16,17,17,18,19,20,20,21,22,23,23,24,25,25,26,27,28,28,29,30,31,31,32
    };
    byte pattern;
    pattern = Man.status & PatternMask;
    if ((Man.status & Movable_Fall) == 0) {
        if (pattern == Pattern_Man_UpDown) {
            byte seq;
            seq = (Man.y >> CoordShift) & 1;
            pattern += seq;
        }
        else if (Man.dx != 0) {
            byte seq;
            seq = (Man.x >> CoordShift) & 3;
            if (seq == 3) {
                seq = 1;
            }
            pattern += seq + 1;
        }
    }
    ShowSprite(&Man, pattern);
    HScroll = ScrollPositions[Man.x >> 2];
}


void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live | Pattern_Man;
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
                                if (Man.x == 128) {
                                    _deb();
                                }
                StartDestruction(column, floor);
                AddScore(1);
            }
            else if ((cell & Cell_UpperMask) == Cell_Item) {
                SetCell(column, floor, cell & Cell_LowerMask);
                ptr<byte> pVram = VramPtr(x, y + StageTop);
                repeat (2) {
                    repeat (2) {
                        pVram = Put(pVram, Char_Space);
                    }
                    pVram += VramRowSize - 2 * VramStep;
                }
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
    static const byte[] patterns = {
        Pattern_Man_Left,
        Pattern_Man_Loose0,
        Pattern_Man_Loose1,
        Pattern_Man_Loose2,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man, patterns[i & 3]);
        UpdateSprites();
        Sound_Loose();
        ++i;
    } while (i < 8);
}
