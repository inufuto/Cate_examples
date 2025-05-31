#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Knife.h"
#include "Sound.h"
#include "VVram.h"

extern void _deb();

constexpr byte PatternMask = 0x0f;
constexpr byte DirectionMask = 0x03;

const ManDirection[] Directions = {
    { -1, 0, 0, Keys_Left },
    { 1, 0, 4, Keys_Right },
    { 0, -1, 8, Keys_Up },
    { 0, 1, 12, Keys_Down },
};
const byte[] ManChars = {
    0xa0, 0x20, 0xff, 0x7b, 0xa0, 0x7b, 0xff, 0x6c,
	0xa0, 0x20, 0xe1, 0x7b, 0x20, 0xa0, 0x6c, 0x7f,
	0x6c, 0xa0, 0x7b, 0x7f, 0x20, 0xa0, 0x6c, 0x61,
	0xa0, 0xff, 0x20, 0x7c, 0xa0, 0xff, 0x7c, 0x6c,
	0xa0, 0x62, 0x20, 0x7c, 0x20, 0x6c, 0xa0, 0x7f,
	0x6c, 0x7c, 0xa0, 0x7f, 0x20, 0x6c, 0xa0, 0xe2,
	0x7c, 0xff, 0x20, 0xa0, 0x7f, 0xa0, 0x7e, 0x20,
};

Man Man;

static void Show()
{
    byte direction = (Man.status >> 2) & DirectionMask;
    byte pattern = (direction << 1) + direction;
    if (Man.dx != 0 || Man.dy != 0) {
        byte seq = (Man.x + Man.y) & 1;
        pattern += seq + 1;
    }
    ShowSprite(&Man, ManChars + (pattern << 2));
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live;
    Man.dx = 0;
    Man.dy = 0;
    Man.pDirection = Directions + Direction_Left;
    LocateMovable(&Man, pStage->start);
    Show();
}


void MoveMan()
{
    static bool keyOn;
    if (((Man.x | Man.y) & CoordMask) == 0) {
        byte key = ScanKeys();
        if ((key & Keys_Dir) != 0) {
            ptr<ManDirection> pDirection = Directions;
            repeat (4) {
                if ((key & pDirection->key ) != 0) {
                    if (CanMove(&Man, pDirection->dx, pDirection->dy)) {
                        Man.pDirection = pDirection;
                        goto move;
                    }
                    else {
                        ptr<ManDirection> pOldDirection = Man.pDirection;
                        if (CanMove(&Man, pOldDirection->dx, pOldDirection->dy)) {
                            Man.pDirection = pOldDirection;
                            goto move;
                        }
                    }
                }
                ++pDirection;
            }
        }
        Man.dx = 0;
        Man.dy = 0;
        goto button;
        
        move:
        {
            ptr<ManDirection> pDirection = Man.pDirection;
            Man.dx = pDirection->dx;
            Man.dy = pDirection->dy;
            Man.status = (Man.status & ~PatternMask) | pDirection->pattern;
        }
        button:
        if ((key & Keys_Button0) != 0) {
            if (!keyOn) {
                StartKnife();
                keyOn = true;
            }
        }
        else {
            keyOn = false;
        }
    }
    MoveMovable(&Man);
    Show();
    if (((Man.x | Man.y) & CoordMask) == 0) {
        PickupKnife();
        if (
            (Man.dx != 0 || Man.dy != 0) &&
            CoordMod(Man.x) == 0 &&
            CoordMod(Man.y) == 0
        ) {
            byte cellType = *CellMapPtr(ToGrid(Man.x), ToGrid(Man.y)) & Cell_TypeMask;
            switch (cellType) {
            case Cell_DownStair:
                ChangeFloor(CurrentFloor + 1);
                break;
            case Cell_UpStair:
                ChangeFloor(CurrentFloor - 1);
                break;
            case Cell_Goal:
                Reached = true;
                break;
            }
        }
    }
}


void LooseMan()
{
    static const byte[] patterns = {
        0 * 4,
        3 * 4,
        12 * 4,
        13 * 4,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man, ManChars + patterns[i & 3]);
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
}
