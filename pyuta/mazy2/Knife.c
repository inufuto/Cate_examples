#include "Knife.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Man.h"
#include "Main.h"
#include "Status.h"
#include "Sound.h"
#include "Math.h"
#include "Monster.h"
#include "Point.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 15;
constexpr byte Visible = 0x08;
constexpr byte Moving = 0x04;
constexpr byte FloorMask = 0x70;
constexpr byte DirectionMask = 0x03;
constexpr byte FloorShift = 4;

static const Direction[] Directions = {
    { -1, 0, Pattern_Knife_Left - Pattern_Knife },
    { 1, 0, Pattern_Knife_Right - Pattern_Knife },
    { 0, -1, Pattern_Knife_Up - Pattern_Knife },
    { 0, 1, Pattern_Knife_Down - Pattern_Knife },
};

// Knife[MaxKnifeCount] Knives;

static byte DirectionToGoal(word pKnife)
{
    byte x = ReadVram(pKnife + Movable_x) >> CoordShift;
    byte y = ReadVram(pKnife + Movable_y) >> CoordShift;
    if (Abs(GoalX, x) >= Abs(GoalY, y)) {
        if (GoalX < x) {
            return Direction_Left;
        }
        return Direction_Right;
    }
    else {
        if (GoalY < y) {
            return Direction_Up;
        }
        return Direction_Down;
    }
}

void InitKnives()
{
    word pKnife = Knives;
    byte totalCount = MaxKnifeCount;
    byte sprite = Sprite_Knife;
    byte floor = 0;
    ptr<Floor> pFloor = pStage->pFloors;
    byte floorCount = pStage->floorCount;
    do {
        byte count = pFloor->knifeCount;
        if (count != 0) {
            ptr<byte> pSource = pFloor->pKnives;
            do {
                WriteVram(pKnife + Movable_sprite, sprite); ++sprite;
                byte position = *pSource; ++pSource;
                LocateMovable(pKnife, position);
                WriteVram(pKnife + Movable_status, Movable_Live | (floor << FloorShift) | DirectionToGoal(pKnife));
                pKnife += Knife_unitSize;
                --totalCount;
            } while (--count != 0);
        }
        ++floor;
        ++pFloor;
    } while (--floorCount != 0);
    while (totalCount != 0) {
        WriteVram(pKnife + Movable_status, 0);
        pKnife += Knife_unitSize;
        --totalCount;
    }
    HeldKnifeCount = 0;
}


static void UpdateVisiblity(word pKnife)
{
    byte cell = ReadVram(CellMapPtr(ToGrid(ReadVram(pKnife + Movable_x)), ToGrid(ReadVram(pKnife + Movable_y))));
    byte status = ReadVram(pKnife + Movable_status);
    if ((cell & Cell_Visible) != 0) {
        status |= Visible;
    }
    else {
        status &= ~Visible;
    }
    WriteVram(pKnife + Movable_status, status);
}

static void Show(word pKnife)
{
    byte status = ReadVram(pKnife + Movable_status);
    if ((status & (Visible | Moving)) != 0) {
        byte pattern = Pattern_Knife + (status & DirectionMask);
        ShowSprite(pKnife, pattern, SpriteColor);
    }
    else {
        HideSprite(ReadVram(pKnife + Movable_sprite));
    }
}

void ShowKnives()
{
    byte sprite = Sprite_Knife;
    repeat (MaxKnifeCount) {
        HideSprite(sprite);
        ++sprite;
    }
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live;
    word pKnife = Knives;
    repeat (MaxKnifeCount) {
        byte status = ReadVram(pKnife + Movable_status);
        if ((status & (Movable_Live | FloorMask)) == floorFilter) {
            UpdateVisiblity(pKnife);
            Show(pKnife);
        }
        pKnife += Knife_unitSize;
    }
}


void PickupKnife()
{
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    byte manX = ReadVram(Man + Movable_x) >> CoordShift;
    byte manY = ReadVram(Man + Movable_y) >> CoordShift;
    word pKnife = Knives;
    repeat (MaxKnifeCount) {
        byte status = ReadVram(pKnife + Movable_status);
        if ((status & (Movable_Live | FloorMask | Visible | Moving)) == floorFilter) {
            byte x = ReadVram(pKnife + Movable_x) >> CoordShift;
            if (manX + 1 >= x && x >= manX) {
                byte y = ReadVram(pKnife + Movable_y) >> CoordShift;
                if (manY + 1 >= y && y >= manY) {
                    ++HeldKnifeCount;
                    WriteVram(pKnife + Movable_status, status & ~(Movable_Live | Visible));
                    Sound_Get();
                    HideSprite(ReadVram(pKnife + Movable_sprite));
                    PrintHeldKnives();
                    PointRate = 0;
                }
            }
        }
        pKnife += Knife_unitSize;
    }
}


static void Hit(word pKnife)
{
    byte x = ReadVram(pKnife + Movable_x);
    byte y = ReadVram(pKnife + Movable_y);
    if (((x | y) & CoordMask) == 0) {
        byte cell = ReadVram(CellMapPtr(ToGrid(x), ToGrid(y)));
        sbyte dx = ReadVram(pKnife + Movable_dx);
        if (dx > 0) {
            if (CoordMod(x) == 1 && (cell & Cell_RightWall) != 0) goto stop;
            goto hittest;
        }
        else if (dx < 0) {
            if (CoordMod(x) == 0 && (cell & Cell_LeftWall) != 0) goto stop;
            goto hittest;
        }
        sbyte dy = ReadVram(pKnife + Movable_dy);
        if (dy > 0) {
            if (CoordMod(y) == 1 && (cell & Cell_BottomWall) != 0) goto stop;
            goto hittest;
        }
        else {
            if (CoordMod(y) == 0 && (cell & Cell_TopWall) != 0) goto stop;
        }
        hittest:
        if (HitMonsters(pKnife)) {
            stop:
            WriteVram(pKnife + Movable_status, Movable_Live | Visible | (CurrentFloor << FloorShift) | DirectionToGoal(pKnife));
            return;
        }
    }
}

void StartKnife()
{
    if (HeldKnifeCount == 0) return;
    word pKnife = Knives;
    repeat (MaxKnifeCount) {
        byte status = ReadVram(pKnife + Movable_status);
        if ((status & Movable_Live) == 0) {
            byte direction = (ReadVram(Man + Movable_status) >> 2) & DirectionMask;
            ptr<Direction> pDirection = Directions + direction;
            sbyte dx = pDirection->dx;
            WriteVram(pKnife + Movable_dx, dx);
            byte x = ReadVram(Man + Movable_x);
            if (dx > 0) x += CoordRate;
            WriteVram(pKnife + Movable_x, x);
            sbyte dy = pDirection->dy;
            WriteVram(pKnife + Movable_dy, dy);
            byte y = ReadVram(Man + Movable_y);
            if (dy > 0) y += CoordRate;
            WriteVram(pKnife + Movable_y, y);
            WriteVram(pKnife + Movable_status, Movable_Live | Moving | pDirection->pattern);
            --HeldKnifeCount;
            Sound_Get();
            PrintHeldKnives();                    
            Hit(pKnife);
            Show(pKnife);
            return;
        }
        pKnife += Knife_unitSize;
    }
}


void MoveKnives()
{
    word pKnife = Knives;
    repeat (MaxKnifeCount) {
        byte status = ReadVram(pKnife + Movable_status);
        if ((status & (Movable_Live | Moving)) == (Movable_Live | Moving)) {
            MoveMovable(pKnife);
            Hit(pKnife);
            Show(pKnife);
        }
        pKnife += Knife_unitSize;
    }
}
