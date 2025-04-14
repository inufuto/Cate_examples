#include "Man.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Block.h"
// #include "Sound.h"
#include "Main.h"
#include "VVram.h"

extern void _deb();

// constexpr byte Color = 15;
constexpr byte PatternMask = 0x0f;
constexpr byte Man_Pushing = 0x20;

struct Direction {
    byte key;
    sbyte dx, dy;
    byte normalPattern, pushingPattern;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, (Char_Man_Left - Char_Man) / 4, (Char_Man_Left_Push - Char_Man) / 4 },
    { Keys_Right, 1, 0, (Char_Man_Right - Char_Man) / 4, (Char_Man_Right_Push - Char_Man) / 4 },
    { Keys_Up, 0, -1, (Char_Man_UpDown - Char_Man) / 4, 0 },
    { Keys_Down, 0, 1, (Char_Man_UpDown - Char_Man) / 4, (Char_Man_Down_Push - Char_Man) / 4 },
};

Man Man;
static ptr<Direction> pManDirection;
static byte pushingTime;

static void Show()
{
    byte pattern;
    if ((Man.status & Man_Pushing) != 0) {
        pattern = pManDirection->pushingPattern;
    }
    else {
        pattern = Man.status & PatternMask;;
        if ((Man.status & Movable_Fall) == 0) {
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
    }
    ShowSprite(&Man, (pattern << 2) + Char_Man);
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live | ((Char_Man_Left - Char_Man) / 4);
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
                            pattern = pManDirection->normalPattern;
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
                                pattern = pManDirection->normalPattern;
                            }
                            else {
                                stop:
                                pManDirection = pDirection;
                                if (pManDirection->dx != 0) {
                                    pattern = pManDirection->normalPattern;
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
                    // Sound_Push();
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
            ptr<byte> pCell = CellMapPtr(column, row);
            byte b = *pCell;
            if ((b & (Cell_Item << 4)) != 0) {
                *pCell = b & ~(Cell_Item << 4);
                // DrawCellCR(column, row);
                --ItemCount;
                AddScore(5);
                // Sound_Hit();
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
    static const byte[] patterns = {
        Char_Man_Left,
        Char_Man_Loose0,
        Char_Man_Loose1,
        Char_Man_Loose2,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man, patterns[i & 3]);
        DrawAll();
        // Sound_Loose();
        Wait(15);
        ++i;
    } while (i < 8);
}


bool HitToMan(ptr<Movable> pMovable)
{
    byte x = pMovable->x + pMovable->dx;
    byte y = pMovable->y + pMovable->dy;
    return IsNearXY(x, y, &Man);
}