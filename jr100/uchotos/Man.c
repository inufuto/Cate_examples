#include "Man.h"
#include "ScanKeys.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fire.h"
#include "Sound.h"
#include "Main.h"
#include "Status.h"
#include "OneUp.h"
#include "Vram.h"

extern void _deb();

// constexpr byte SpriteColor = 15;

constexpr byte Man_Fall = 0x80;
constexpr byte Man_PatternMask = 0x0f;

constexpr byte TimerValue = 16;

static const ManDirection[] Directions = {
    { Keys_Left, -1, 0, 0 },
    { Keys_Right, 1, 0, 4 },
    { Keys_Up, 0, -1, 8 },
    { Keys_Down, 0, 1, 8 },
};

Man Man;
ptr<ManDirection> pManDirection;
static byte invincibleCount;
static byte manPattern;

void ShowMan()
{
    static byte clock;
    ++clock;
    if (invincibleCount != 0 && (clock & 1) != 0) {
        HideSprite(Man.sprite);
        return;
    }
    ShowSpriteC(&Man, Char_Man);
}


static void UpdatePattern()
{
        byte status = Man.status;
    byte pattern;
    if (Man.dy == 0) {
        pattern = status & Man_PatternMask;
        if (Man.dx != 0) {
            byte seq = ((Man.x | Man.y) >> CoordShift) & 3;
            if (seq == 3) {
                seq = 1;
            }
            pattern += seq + 1;
        }
    }
    else {
        if ((status & Man_Fall) != 0) {
            pattern = status & Man_PatternMask;
        }
        else {
            pattern = 8;
            pattern += (Man.y >> CoordShift) & 1;
        }
    }
    pattern = (pattern << 2) + Ptn_Man;
    if (manPattern != pattern) {
        manPattern = pattern;
        SetPattern(Char_Man, pattern, 4);
    }
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = 0;
    Man.dx = 0;
    Man.dy = 0;
    invincibleCount = 0;
    LocateMovable(&Man, pStage->start);
    manPattern = 0xff;
    UpdatePattern();
    ShowMan();
}


static bool CanMoveMan(sbyte dx, sbyte dy)
{
    if (!CanMove(&Man, dx, dy)) return false;
    if ((NextCell & Cell_Debri) != 0) return false;
    return dy == 0 || NextCell != Cell_Space;
}

void MoveMan()
{
    static byte clock;
    ++clock;
    // if ((clock & CoordMask) == 0) {
        if (invincibleCount != 0) {
            --invincibleCount;
        }
    // }
    if (IsOnGrid(&Man)) {
        if ((Man.status & Man_Fall) == 0) {
            byte key = ScanKeys();
            if ((key & Keys_Dir) != 0) {
                ptr<ManDirection> pDirection = Directions;
                repeat (4) {
                    if ((key & pDirection->key) != 0) {
                        if (CanMoveMan(pDirection->dx, pDirection->dy)) {
                            pManDirection = pDirection;
                            Man.status = (Man.status & ~Man_PatternMask) | pDirection->pattern;
                            goto move;
                        }
                        if (!CanMoveMan(pManDirection->dx, pManDirection->dy)) {
                            pManDirection = pDirection;
                            Man.status = (Man.status & ~Man_PatternMask) | pDirection->pattern;
                            stop:
                            Man.dx = 0;
                            Man.dy = 0;
                            goto skip;
                        }
                        goto move;
                    }
                    ++pDirection;
                }
            }
            goto stop;
            move:
            Man.dx = pManDirection->dx;
            Man.dy = pManDirection->dy;
        }
        else {
            byte column = Man.x >> CellCoordShift;
            byte row = (Man.y >> CellCoordShift) + 1;
            byte cell = GetCell(column, row);
            if (cell != Cell_Space && cell != Cell_Item) {
                Man.status &= ~Man_Fall;
                Man.dy = 0;
            }
        }
    }
    Man.x += Man.dx;
    Man.y += Man.dy;
    if (IsOnGrid(&Man)) {
        byte column = Man.x >> CellCoordShift;
        {
            byte row = (Man.y >> CellCoordShift);
            byte cell = GetCell(column, row);
            if (cell == Cell_Item) {
                SetCell(column, row, Cell_Space);
                --ItemCount;
                AddScore(5);
                Sound_Hit();
            }
        }
        {
            byte row = (Man.y >> CellCoordShift) + 1;
            if (row >= RowCount) goto fall;
            byte cell = GetCell(column, row);
            if (cell == Cell_Space || cell == Cell_Item) {
                fall:
                Man.status |= Man_Fall;
                Man.dx = 0;
                Man.dy = 1;
            }
        }
    }
    skip:;
    UpdatePattern();
    if ((clock & CellCoordMask) == 0 && Man.dx == 0) {
        byte column = Man.x >> CellCoordShift;
        byte row = (Man.y >> CellCoordShift) + 1;
        if (row < RowCount) {
            byte cell = GetCell(column, row);
            if ((cell & Cell_Debri) != 0) {
                cell -= 0x04;
                SetCell(column, row, cell);
                if (cell == Cell_Space) {
                    Man.status |= Man_Fall;
                    Man.dx = 0;
                    Man.dy = 1;
                }
            }
        }
    }
    if (IsOnGrid(&Man)) {
        HitOneUp(&Man);
    }
}


void HitToMan(ptr<Movable> pMovable)
{
    if (invincibleCount != 0) {
        return;
    }
    if (IsNear(pMovable, &Man)) {
        invincibleCount = TimerValue;
        HideSprite(Sprite_Man);
        --RemainCount;
        PrintRemain();
        Sound_Loose();
    }
}
