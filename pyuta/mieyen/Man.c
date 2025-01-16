#include "Man.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Sound.h"
#include "Fire.h"
#include "Main.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 15;

static const byte[] Keys = { Keys_Left, Keys_Right, Keys_Up, Keys_Down };

// Man Man;
ptr<Direction> pManDirection;


static void Show()
{
    ShowMovable(Man, Pattern_Man, SpriteColor);
}

void InitMan()
{
    WriteVram(Man + Movable_sprite, Sprite_Man);
    WriteVram(Man + Movable_status, Movable_Live);
    WriteVram(Man + Movable_dx, 0);
    WriteVram(Man + Movable_dy, 0);
    pManDirection = Directions + Direction_Left;
    LocateMovable(Man, pStage->start);
    Show();
}


void MoveMan()
{
    static byte clock;
    constexpr byte FireInterval = CoordRate * 4 - 1;
    static byte keyCount;
    if (((ReadVram(Man + Movable_x) | ReadVram(Man + Movable_y)) & CoordMask) == 0) {
        byte key = ScanKeys();
        if ((key & Keys_Dir) != 0) {
            ptr<Direction> pDirection = Directions;
            ptr<byte> pKey = Keys;
            repeat (4) {
                if ((key & *pKey) != 0) {
                    if (CanMove(Man, pDirection->dx, pDirection->dy)) {
                        pManDirection = pDirection;
                        goto move;
                    }
                    else if (CanMove(Man, pManDirection->dx, pManDirection->dy)) {
                        goto move;
                    }
                }
                ++pDirection;
                ++pKey;
            }
        }
        WriteVram(Man + Movable_dx, 0);
        WriteVram(Man + Movable_dy, 0);
        goto button;
        move:;
        SetDirection(Man, pManDirection);
        button:
        if ((key & Keys_Button0) != 0) {
            if (keyCount == 0) {
                StartFire();
                keyCount = FireInterval;
            }
            else {
                --keyCount;
            }
        }
        else {
            keyCount = 0;
        }
    }
    MoveMovable(Man);
    if (IsOnGrid(Man)) {
        byte column = ToGrid(ReadVram(Man + Movable_x));
        byte row = ToGrid(ReadVram(Man + Movable_y));
        byte cell = GetCell(column, row);
        if ((cell & (Cell_Dot | Cell_Food)) == 0) {
            SetCell(column, row, cell | Cell_Dot);
            AddScore(1);
        }
    }
    Show();
    ++clock;
}


// void FreezeMan()
// {
//     (Man + Movable_status = ((Man + Movable_status & ~Movable_Pattern) | (Movable_Loose | Movable_Live);
//     Sound_Stole();
// }


void LooseMan()
{
    byte i;
    i = 0;
    do {
        ShowSprite(Man, Pattern_Man + ((i & 3) << 1), SpriteColor);
        UpdateSprites();
        Sound_Loose();
        ++i;
    } while (i < 8);
}
