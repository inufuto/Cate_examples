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

Knife[MaxKnifeCount] Knives;

static byte DirectionToGoal(ptr<Knife> pKnife)
{
    byte x = pKnife->x >> CoordShift;
    byte y = pKnife->y >> CoordShift;
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
    ptr<Knife> pKnife = Knives;
    _deb();
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
                pKnife->sprite = sprite; ++sprite;
                byte position = *pSource; ++pSource;
                LocateMovable(pKnife, position);
                pKnife->status = Movable_Live | (floor << FloorShift) | DirectionToGoal(pKnife);
                ++pKnife;
                --totalCount;
            } while (--count != 0);
        }
        ++floor;
        ++pFloor;
    } while (--floorCount != 0);
    while (totalCount != 0) {
        pKnife->status = 0;
        ++pKnife;
        --totalCount;
    }
    HeldKnifeCount = 0;
}


static void UpdateVisiblity(ptr<Knife> pKnife)
{
    byte cell = *CellMapPtr(ToGrid(pKnife->x), ToGrid(pKnife->y));
    if ((cell & Cell_Visible) != 0) {
        pKnife->status |= Visible;
    }
    else {
        pKnife->status &= ~Visible;
    }
}

static void Show(ptr<Knife> pKnife)
{
    byte status = pKnife->status;
    if ((status & (Visible | Moving)) != 0) {
        byte pattern = Pattern_Knife + (status & DirectionMask);
        ShowSprite(pKnife, pattern, SpriteColor);
    }
    else {
        HideSprite(pKnife->sprite);
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
    ptr<Knife> pKnife;
    for (pKnife: Knives) {
        byte status = pKnife->status;
        if ((status & (Movable_Live | FloorMask)) == floorFilter) {
            UpdateVisiblity(pKnife);
            Show(pKnife);
        }
    }
}


void PickupKnife()
{
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    byte manX = Man.x >> CoordShift;
    byte manY = Man.y >> CoordShift;
    ptr<Knife> pKnife;
    for (pKnife: Knives) {
        byte status = pKnife->status;
        if ((status & (Movable_Live | FloorMask | Visible | Moving)) == floorFilter) {
            byte x = pKnife->x >> CoordShift;
            if (manX + 1 >= x && x >= manX) {
                byte y = pKnife->y >> CoordShift;
                if (manY + 1 >= y && y >= manY) {
                    ++HeldKnifeCount;
                    pKnife->status = status & ~(Movable_Live | Visible);
                    Sound_Get();
                    HideSprite(pKnife->sprite);
                    PrintHeldKnives();
                    PointRate = 0;
                }
            }
        }
    }
}


static void Hit(ptr<Knife> pKnife)
{
    byte x = pKnife->x;
    byte y = pKnife->y;
    if (((x | y) & CoordMask) == 0) {
        byte cell = *CellMapPtr(ToGrid(x), ToGrid(y));
        sbyte dx = pKnife->dx;
        if (dx > 0) {
            if (CoordMod(x) == 1 && (cell & Cell_RightWall) != 0) goto stop;
            goto hittest;
        }
        else if (dx < 0) {
            if (CoordMod(x) == 0 && (cell & Cell_LeftWall) != 0) goto stop;
            goto hittest;
        }
        sbyte dy = pKnife->dy;
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
            pKnife->status = Movable_Live | Visible | (CurrentFloor << FloorShift) | DirectionToGoal(pKnife);
            return;
        }
    }
}

void StartKnife()
{
    if (HeldKnifeCount == 0) return;
    ptr<Knife> pKnife;
    for (pKnife: Knives) {
        byte status = pKnife->status;
        if ((status & Movable_Live) == 0) {
            byte direction = (Man.status >> 2) & DirectionMask;
            ptr<Direction> pDirection = Directions + direction;
            sbyte dx = pDirection->dx;
            pKnife->dx = dx;
            byte x = Man.x;
            if (dx > 0) x += CoordRate;
            pKnife->x = x;
            sbyte dy = pDirection->dy;
            pKnife->dy = dy;
            byte y = Man.y;
            if (dy > 0) y += CoordRate;
            pKnife->y = y;
            pKnife->status = Movable_Live | Moving | pDirection->pattern;
            --HeldKnifeCount;
            Sound_Get();
            PrintHeldKnives();                    
            Hit(pKnife);
            Show(pKnife);
            return;
        }
    }
}


void MoveKnives()
{
    ptr<Knife> pKnife;
    for (pKnife: Knives) {
        byte status = pKnife->status;
        if ((status & (Movable_Live | Moving)) == (Movable_Live | Moving)) {
            MoveMovable(pKnife);
            Hit(pKnife);
            Show(pKnife);
        }
    }
}
