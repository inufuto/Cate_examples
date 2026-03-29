#include "Man.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Sound.h"
#include "Flag.h"

extern void _deb();

constexpr byte CellCoordMask = 2 * CoordRate - 1;
constexpr byte SpriteColor = 15;

struct Direction {
    byte key;
    sbyte dx, dy;
    byte pattern;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, Pattern_Man_Left },
    { Keys_Right, 1, 0, Pattern_Man_Right },
    { Keys_Up, 0, -1, Pattern_Man_UpDown },
    { Keys_Down, 0, 1, Pattern_Man_UpDown },
};

Man Man;
static ptr<Direction> pManDirection;
static sbyte LastDx;

static void Show()
{
    byte pattern = Man.status & Actor_PatternMask;
    if ((Man.status & Actor_Fall) == 0) {
        if (Man.dy != 0) {
            byte seq = (Man.y >> CoordShift) & 1;
            pattern += seq;
        }
        else {
            if (Man.dx != 0) {
                byte seq = (Man.x >> CoordShift) & 3;
                if (seq == 3) {
                    seq = 1;
                }
                pattern += seq + 1;
            }
        }
    }
    ShowSprite(&Man, Pattern_Man + pattern, SpriteColor);
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live;
    Man.dx = 0;
    Man.dy = 0;
    LastDx = -1;
    pManDirection = Directions;
    LocateActor(&Man, pStage->start);
    Show();
}


void MoveMan()
{
    if (Scrolling != 0) return;
    if (((Man.x | Man.y) & CoordMask) == 0) {
        static bool keyOn;
        sbyte dx = 0; 
        sbyte dy = 0;
        byte pattern = Man.status & Actor_PatternMask;
        if ((Man.status & Actor_Fall) == 0) {
            byte key = ScanKeys();
            if ((key & Keys_Dir) != 0) {
                ptr<Direction> pDirection = Directions;
                repeat (4) {
                    if ((pDirection->key & key) != 0) {
                        dx = pDirection->dx;
                        dy = pDirection->dy;
                        if (CanMove(&Man, dx, dy)) {
                            pManDirection = pDirection;
                        }
                        else {
                            if (
                                CanMove(&Man, pManDirection->dx, pManDirection->dy)
                            ) {
                                dx = pManDirection->dx;
                                dy = pManDirection->dy;
                            }
                            else {
                                pManDirection = pDirection;
                                dx = 0;
                                dy = 0;
                            }
                        }
                        pattern = pManDirection->pattern;
                        LastDx = pManDirection->dx;
                        break;
                    }
                    ++pDirection;
                }
            }
            if (dx != 0) {
                LastDx = dx;
            }
            Man.dx = dx;
            Man.dy = dy;
            Man.status = (Man.status & ~Actor_PatternMask) | pattern;

            if ((key & Keys_Button0) != 0) {
                if (!keyOn) {
                    sbyte dx;
                    byte column;
                    byte x = Man.x >> CoordShift;
                    if (LastDx < 0) {
                        column = (x >> ColumnShift) - 1;
                        dx = 1;
                    }
                    else {
                        column = ((x + 1) >> ColumnShift) + 1;
                        dx = -1;
                    }
                    column &= ColumnCount - 1;
                    byte row = Man.y >> (CoordShift + RowShift);
                    byte cell = GetCell(column, row);
                    if (cell != Cell_Bomb) {
                        ScrollingFloor = row >> 1;
                        ScrollingClock = 0;
                        Scrolling = dx;
                        Sound_Move();
                        keyOn = true;
                        Man.dx = 0;
                    }
                }
            }
            else {
                keyOn = false;
            }
        }
    }
    MoveActor(&Man);
    if ((Man.y & CellCoordMask) == 0) {
        if ((Man.x & CellCoordMask) == 0) {
            byte x = Man.x >> CoordShift;
            byte y = Man.y >> CoordShift;
            if ((x & (ColumnWidth - 1)) == 0 && (y & (FloorHeight - 1)) == 0) {
                byte column = x >> ColumnShift;
                byte floor = y >> FloorShift;
                if ((*MapPtr(column, floor) & (Cell_Flag << 4)) != 0) {
                    HitFlags(column, floor);
                }
            }
        }
        if ((Man.x & CoordMask) == 0 && FallActor(&Man)) {
            Man.dy = 1;
            Man.dx = 0;
            pManDirection = Directions + Direction_Down;
        }
    }
    Show();    
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
        ShowSprite(&Man, patterns[i & 3], SpriteColor);
        Sound_Loose();
        ++i;
    } while (i < 8);
}


// void SlideMan(sbyte dx)
// {
//     Man.x += dx;
//     Show();
// }