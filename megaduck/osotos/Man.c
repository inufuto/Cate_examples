#include "Man.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Block.h"
#include "Sound.h"
#include "Main.h"
#include "Vram.h"

extern void _deb();

constexpr byte Color = 15;
constexpr byte PatternMask = 0x0f;
constexpr byte Man_Pushing = 0x20;

struct Direction {
    byte key;
    sbyte dx, dy;
    byte normalPattern, pushingPattern;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, (Pattern_Man_Left - Pattern_Man), (Pattern_Man_Left_Push - Pattern_Man) },
    { Keys_Right, 1, 0, (Pattern_Man_Right - Pattern_Man), (Pattern_Man_Right_Push - Pattern_Man) },
    { Keys_Up, 0, -1, (Pattern_Man_UpDown - Pattern_Man), 0 },
    { Keys_Down, 0, 1, (Pattern_Man_UpDown - Pattern_Man), (Pattern_Man_Down_Push - Pattern_Man) },
};

Man Man;
static ptr<Direction> pManDirection;
static byte pushingTime;

static void Show()
{
    static const byte[] ScrollPositions = {
        0,1,1,2,3,4,4,5,6,7,7,8,9,9,10,11,12,12,13,14,15,15,16,17,17,18,19,20,20,21,22,23,23,24,25,25,26,27,28,28,29,30,31,31,32
    };
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
    ShowSprite(&Man, pattern + Pattern_Man);
    HScroll = ScrollPositions[Man.x >> 2];
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live | ((Pattern_Man_Left - Pattern_Man));
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
            ptr<byte> pCell = CellMapPtr(column, row);
            byte b = *pCell;
            if ((b & (Cell_Item << 4)) != 0) {
                *pCell = b & ~(Cell_Item << 4);
                DrawCellCR(column, row);
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


bool HitToMan(ptr<Movable> pMovable)
{
    byte x = pMovable->x + pMovable->dx;
    byte y = pMovable->y + pMovable->dy;
    return IsNearXY(x, y, &Man);
}