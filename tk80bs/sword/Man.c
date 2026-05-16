#include "Man.h"
#include "Stage.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "Sound.h"
#include "Monster.h"
#include "Status.h"
#include "Main.h"
#include "Point.h"
#include "OneUp.h"

struct Direction {
    byte key;
    sbyte dx, dy;
    byte pattern;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, 0 },
    { Keys_Right, 1, 0, 4 },
    { Keys_Up, 0, -1, 8 },
    { Keys_Down, 0, 1, 12 },
};
const byte[] ManChars = {
    0x83, 0x82, 0xa9, 0xa2, 0x83, 0x82, 0x20, 0x82,
	0x80, 0x20, 0xa3, 0xaa, 0x20, 0x20, 0x9a, 0xa4,
	0x83, 0x82, 0xa3, 0xaa, 0x83, 0x82, 0x83, 0x20,
	0x20, 0x80, 0xa9, 0xa2, 0x20, 0x20, 0xa4, 0x9a,
	0x91, 0xa9, 0x90, 0xa2, 0x91, 0x20, 0x90, 0x90,
	0x80, 0xa3, 0x20, 0xab, 0x20, 0x8b, 0x20, 0xa4,
	0x91, 0xa3, 0x90, 0xab, 0x91, 0x91, 0x90, 0x20,
	0x20, 0xa9, 0x80, 0xa2, 0x20, 0xa4, 0x20, 0x8b,
};

Man Man;
Movable Sword;
static ptr<Direction> pManDirection;
static byte thrustCount;
static byte invincibleCount;

static void Show()
{
    if (invincibleCount != 0 && (invincibleCount & 1) != 0) {
        HideSprite(Man.sprite);
        return;
    }
    byte status = Man.status;
    byte pattern = status & Actor_PatternMask;
    if ((status & Man_Attacking) != 0) {
        ShowSprite(&Sword, ManChars + ((pattern + 3) << 2));
        pattern += 2;
    }
    else if (Man.dx != 0 || Man.dy != 0) {
        byte seq = ((Man.x | Man.y) >> CoordShift) & 1;
        pattern += seq;
    }
    ShowSprite(&Man, ManChars + (pattern << 2));
}

void InitMan()
{
    invincibleCount = 0;
    Man.sprite = Sprite_Man;
    Man.status = 0;
    Man.dx = 0;
    Man.dy = 0;
    LocateActor(&Man, pStage->start);
    Show();
    Sword.sprite = Sprite_Man + 1;
    HideSprite(Sword.sprite);
    thrustCount = 1;
    pManDirection = Directions;
}

static bool CanMove(sbyte dx, sbyte dy)
{
    byte nextColumn = (Man.x >> GridCoordShift) + dx;
    if (nextColumn >= ColumnCount) return false;
    byte nextRow = (Man.y >> GridCoordShift) + dy;
    if (nextRow >= RowCount) return false;
    byte cell = GetCell(nextColumn, nextRow);
    return cell != Cell_Wall;
}

void MoveMan()
{
    static byte clock;
    static bool keyOn;
    ++clock;
    if ((clock & CoordMask) == 0) {
        if (invincibleCount != 0) {
            --invincibleCount;
        }
    }
    if (((Man.x | Man.y) & GridCoordMask) == 0) {
        byte status = Man.status;
        if ((status & Man_Attacking) != 0) {
            if (!CanMove(Man.dx, Man.dy)) {
                Man.count = 0;
            }
            else {
                --Man.count;
            }
            if (Man.count == 0) {
                Man.dx = 0;
                Man.dy = 0;
                Man.status &= ~Man_Attacking;
                HideSprite(Sword.sprite);
            }
            if ((ScanKeys() & Keys_Button0) == 0) {
                keyOn = false;
            }
        }
        else {
            sbyte dx = 0; 
            sbyte dy = 0;
            byte pattern = status & Actor_PatternMask;
            byte key = ScanKeys();
            if ((key & Keys_Dir) != 0) {
                ptr<Direction> pDirection = Directions;
                repeat (4) {
                    if ((pDirection->key & key) != 0) {
                        dx = pDirection->dx;
                        dy = pDirection->dy;
                        if (CanMove(dx, dy)) {
                            pManDirection = pDirection;
                        }
                        else {
                            if (
                                CanMove(pManDirection->dx, pManDirection->dy)
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
                        break;
                    }
                    ++pDirection;
                }
            }
            Man.dx = dx;
            Man.dy = dy;
            Man.status = (Man.status & ~Actor_PatternMask) | pattern;

            if ((key & Keys_Button0) != 0) {
                if (!keyOn) {
                    dx = pManDirection->dx;
                    dy = pManDirection->dy;
                    if (CanMove(dx, dy)) {
                        Man.dx = dx;
                        Man.dy = dy;
                        Man.status |= Man_Attacking;
                        Sword.x = Man.x + (dx << (CoordShift + 1));
                        Sword.y = Man.y + (dy << (CoordShift + 1));
                        Man.count = thrustCount;
                        PointRate = 0;
                        Sound_Attack();
                        keyOn = true;
                        HitMonsters(Sword.x, Sword.y);
                    }
                }
            }
            else {
                keyOn = false;
            }
        }
    }
    MoveActor(&Man);
    if ((Man.status & Man_Attacking) != 0) {
        Sword.x += Man.dx;
        Sword.y += Man.dy;
        if (((Sword.x | Sword.y) & CoordMask) == 0) {
            HitMonsters(Sword.x, Sword.y);
        }
        MoveActor(&Man);
        Sword.x += Man.dx;
        Sword.y += Man.dy;
        if (((Sword.x | Sword.y) & CoordMask) == 0) {
            HitMonsters(Sword.x, Sword.y);
        }
    }
    Show();
    if (((Man.x | Man.y) & GridCoordMask) == 0) {
        byte column = Man.x >> GridCoordShift;
        byte row = Man.y >> GridCoordShift;
        byte cell = GetCell(column, row);
        if (cell == Cell_Item) {
            SetCell(column, row, Cell_Space);
            AddScore(10);
            Sound_Up();
            ++thrustCount;
        }
        else if (cell == Cell_Box) {
            SetCell(column, row, Cell_Space);
            AddScore(5);
            --BoxCount;
            Sound_Hit();
        }
        HitOneUp(Man.x, Man.y);
    }
}


void HitMan(byte x, byte y)
{
    if (invincibleCount != 0) {
        return;
    }
    if (IsNear(&Man, x, y)) {
        invincibleCount = TimerValue;
        HideSprite(Sprite_Man);
        --RemainCount;
        PrintRemain();
        Sound_Loose();
    }
}


void ShowMan()
{
    invincibleCount = 0;
    HideSprite(Sword.sprite);
    Show();
}