#include "Man.h"
#include "Stage.h"
#include "Sprite.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Sound.h"
#include "Monster.h"
#include "Status.h"
#include "Main.h"
#include "Point.h"
#include "OneUp.h"
#include "Vram.h"

constexpr byte ManColor = 7;
constexpr byte SwordColor = ManColor;

struct Direction {
    byte key;
    sbyte dx, dy;
    byte pattern;
};
static const Direction[] Directions = {
    { Keys_Left, -1, 0, Pattern_Man_Left },
    { Keys_Right, 1, 0, Pattern_Man_Right },
    { Keys_Up, 0, -1, Pattern_Man_Up },
    { Keys_Down, 0, 1, Pattern_Man_Down },
};

// Man Man;
// Movable Sword;
static ptr<Direction> pManDirection;
static byte thrustCount;
static byte invincibleCount;

static void Show()
{
    if (invincibleCount != 0 && (invincibleCount & 1) != 0) {
        HideSprite(ReadVram(Man + Movable_sprite));
        return;
    }
    byte status = ReadVram(Man + Actor_status);
    byte pattern = status & Actor_PatternMask;
    if ((status & Man_Attacking) != 0) {
        ShowSprite(Sword, pattern + 3, SwordColor);
        pattern += 2;
    }
    else if ((ReadVram(Man + Actor_dx) != 0 || ReadVram(Man + Actor_dy) != 0)) {
        byte seq = (((ReadVram(Man + Movable_x) | ReadVram(Man + Movable_y)) >> CoordShift) & 1);
        pattern += seq;
    }
    ShowSprite(Man, pattern + Pattern_Man, ManColor);
}

void InitMan()
{
    invincibleCount = 0;
    WriteVram(Man + Movable_sprite, Sprite_Man);
    WriteVram(Man + Actor_status, 0);
    WriteVram(Man + Actor_dx, 0);
    WriteVram(Man + Actor_dy, 0);
    LocateActor(Man, pStage->start);
    Show();
    WriteVram(Sword + Movable_sprite, Sprite_Man + 1);
    HideSprite(ReadVram(Sword + Movable_sprite));
    thrustCount = 1;
    pManDirection = Directions;
}

static bool CanMove(sbyte dx, sbyte dy)
{
    byte nextColumn = ((ReadVram(Man + Movable_x) >> GridCoordShift) + dx);
    if (nextColumn >= ColumnCount) return false;
    byte nextRow = ((ReadVram(Man + Movable_y) >> GridCoordShift) + dy);
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
    if (((ReadVram(Man + Movable_x) | ReadVram(Man + Movable_y)) & GridCoordMask) == 0) {
        byte status = ReadVram(Man + Actor_status);
        if ((status & Man_Attacking) != 0) {
            if (!CanMove(ReadVram(Man + Actor_dx), ReadVram(Man + Actor_dy))) {
                WriteVram(Man + Man_count, 0);
            }
            else {
                WriteVram(Man + Man_count, ReadVram(Man + Man_count) - 1);
            }
            if (ReadVram(Man + Man_count) == 0) {
                WriteVram(Man + Actor_dx, 0);
                WriteVram(Man + Actor_dy, 0);
                WriteVram(Man + Actor_status, ReadVram(Man + Actor_status) & ~Man_Attacking);
                HideSprite(ReadVram(Sword + Movable_sprite));
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
            WriteVram(Man + Actor_dx, dx);
            WriteVram(Man + Actor_dy, dy);
            WriteVram(Man + Actor_status, (ReadVram(Man + Actor_status) & ~Actor_PatternMask) | pattern);

            if ((key & Keys_Button0) != 0) {
                if (!keyOn) {
                    dx = pManDirection->dx;
                    dy = pManDirection->dy;
                    if (CanMove(dx, dy)) {
                        WriteVram(Man + Actor_dx, dx);
                        WriteVram(Man + Actor_dy, dy);
                        WriteVram(Man + Actor_status, ReadVram(Man + Actor_status) | Man_Attacking);
                        WriteVram(Sword + Movable_x, ReadVram(Man + Movable_x) + (dx << (CoordShift + 1)));
                        WriteVram(Sword + Movable_y, ReadVram(Man + Movable_y) + (dy << (CoordShift + 1)));
                        WriteVram(Man + Man_count, thrustCount);
                        PointRate = 0;
                        Sound_Attack();
                        keyOn = true;
                        HitMonsters(ReadVram(Sword + Movable_x), ReadVram(Sword + Movable_y));
                    }
                }
            }
            else {
                keyOn = false;
            }
        }
    }
    MoveActor(Man);
    if ((ReadVram(Man + Actor_status) & Man_Attacking) != 0) {
        WriteVram(Sword + Movable_x, ReadVram(Sword + Movable_x) + ReadVram(Man + Actor_dx));
        WriteVram(Sword + Movable_y, ReadVram(Sword + Movable_y) + ReadVram(Man + Actor_dy));
        if (((ReadVram(Sword + Movable_x) | ReadVram(Sword + Movable_y)) & CoordMask) == 0) {
            HitMonsters(ReadVram(Sword + Movable_x), ReadVram(Sword + Movable_y));
        }
        MoveActor(Man);
        WriteVram(Sword + Movable_x, ReadVram(Sword + Movable_x) + ReadVram(Man + Actor_dx));
        WriteVram(Sword + Movable_y, ReadVram(Sword + Movable_y) + ReadVram(Man + Actor_dy));
        if (((ReadVram(Sword + Movable_x) | ReadVram(Sword + Movable_y)) & CoordMask) == 0) {
            HitMonsters(ReadVram(Sword + Movable_x), ReadVram(Sword + Movable_y));
        }
    }
    Show();
    if (((ReadVram(Man + Movable_x) | ReadVram(Man + Movable_y)) & GridCoordMask) == 0) {
        byte column = (ReadVram(Man + Movable_x) >> GridCoordShift);
        byte row = (ReadVram(Man + Movable_y) >> GridCoordShift);
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
        HitOneUp(ReadVram(Man + Movable_x), ReadVram(Man + Movable_y));
    }
}


void HitMan(byte x, byte y)
{
    if (invincibleCount != 0) {
        return;
    }
    if (IsNear(Man, x, y)) {
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
    HideSprite(ReadVram(Sword + Movable_sprite));
    Show();
}