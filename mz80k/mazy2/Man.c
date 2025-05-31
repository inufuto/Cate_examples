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
    0x43, 0x00, 0xf6, 0xf4, 0x43, 0xf4, 0xf6, 0xf8,
	0x43, 0x00, 0xfa, 0xf4, 0x00, 0x43, 0xf8, 0xf9,
	0xf8, 0x43, 0xf4, 0xf9, 0x00, 0x43, 0xf8, 0xf5,
	0x43, 0xf6, 0x00, 0xf2, 0x43, 0xf6, 0xf2, 0xf8,
	0x43, 0xfc, 0x00, 0xf2, 0x00, 0xf8, 0x43, 0xf9,
	0xf8, 0xf2, 0x43, 0xf9, 0x00, 0xf8, 0x43, 0xf3,
	0xf2, 0xf6, 0x00, 0x43, 0xf9, 0x43, 0xf1, 0x00,
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
