#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Knife.h"
#include "Sound.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 15;
constexpr byte PatternMask = 0x0f;

const ManDirection[] Directions = {
    { -1, 0, Pattern_Man_Left - Pattern_Man, Keys_Left },
    { 1, 0, Pattern_Man_Right - Pattern_Man, Keys_Right },
    { 0, -1, Pattern_Man_Up - Pattern_Man, Keys_Up },
    { 0, 1, Pattern_Man_Down - Pattern_Man, Keys_Down },
};

// Man Man;

static void Show()
{
    byte pattern = ReadVram(Man + Movable_status) & PatternMask;
    if (ReadVram(Man + Movable_dx) != 0 || ReadVram(Man + Movable_dy) != 0) {
        byte seq = ((ReadVram(Man + Movable_x) + ReadVram(Man + Movable_y)) >> CoordShift) & 3;
        if (seq == 3) {
            seq = 1;
        }
        pattern += seq + 1;
    }
    ShowSprite(Man, Pattern_Man + pattern, SpriteColor);
}

void InitMan()
{
    WriteVram(Man + Movable_sprite, Sprite_Man);
    WriteVram(Man + Movable_status, Movable_Live);
    WriteVram(Man + Movable_dx, 0);
    WriteVram(Man + Movable_dy, 0);
    WriteVramWord(Man + Man_pDirection, (word)Directions + Direction_Left);
    LocateMovable(Man, pStage->start);
    Show();
}


void MoveMan()
{
    static bool keyOn;
    if (((ReadVram(Man + Movable_x) | ReadVram(Man + Movable_y)) & CoordMask) == 0) {
        byte key = ScanKeys();
        if ((key & Keys_Dir) != 0) {
            ptr<ManDirection> pDirection = Directions;
            repeat (4) {
                if ((key & pDirection->key ) != 0) {
                    if (CanMove(Man, pDirection->dx, pDirection->dy)) {
                        WriteVramWord(Man + Man_pDirection, (word)pDirection);
                        goto move;
                    }
                    else {
                        ptr<ManDirection> pOldDirection = (ptr<ManDirection>)ReadVramWord(Man + Man_pDirection);
                        if (CanMove(Man, pOldDirection->dx, pOldDirection->dy)) {
                            WriteVramWord(Man + Man_pDirection, (word)pOldDirection);
                            goto move;
                        }
                    }
                }
                ++pDirection;
            }
        }
        WriteVram(Man + Movable_dx, 0);
        WriteVram(Man + Movable_dy, 0);
        goto button;
        
        move:
        {
            ptr<ManDirection> pDirection = (ptr<ManDirection>)ReadVramWord(Man + Man_pDirection);
            WriteVram(Man + Movable_dx, pDirection->dx);
            WriteVram(Man + Movable_dy, pDirection->dy);
            WriteVram(Man + Movable_status, (ReadVram(Man + Movable_status) & ~PatternMask) | pDirection->pattern);
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
    MoveMovable(Man);
    Show();
    if (((ReadVram(Man + Movable_x) | ReadVram(Man + Movable_y)) & CoordMask) == 0) {
        PickupKnife();
        if (
            (ReadVram(Man + Movable_dx) != 0 || ReadVram(Man + Movable_dy) != 0) &&
            CoordMod(ReadVram(Man + Movable_x)) == 0 &&
            CoordMod(ReadVram(Man + Movable_y)) == 0
        ) {
            byte cellType = ReadVram(CellMapPtr(ToGrid(ReadVram(Man + Movable_x)), ToGrid(ReadVram(Man + Movable_y)))) & Cell_TypeMask;
            switch (cellType)
            {
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
        Pattern_Man_Left,
        Pattern_Man_Down,
        Pattern_Man_Loose2,
        Pattern_Man_Loose3,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(Man, patterns[i & 3], SpriteColor);
        PollVSync();
        Sound_Loose();
        ++i;
    } while (i < 8);
}
