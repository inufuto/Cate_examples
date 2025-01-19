#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Sound.h"
#include "Fire.h"
#include "Main.h"
#include "VVram.h"

extern void _deb();

const byte[] ManChars = {
    0xfb, 0xf9, 0xc4, 0xc4, 0xf6, 0xf7, 0xc3, 0xc3,
	0xff, 0xff, 0xc2, 0xc2, 0xfb, 0xf7, 0xc1, 0xc1,
};
static const byte[] Keys = { Keys_Left, Keys_Right, Keys_Up, Keys_Down };

Man Man;
ptr<Direction> pManDirection;


static void Show()
{
    ShowMovable(&Man, ManChars);
}

void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live;
    Man.dx = 0;
    Man.dy = 0;
    pManDirection = Directions + Direction_Left;
    LocateMovable(&Man, pStage->start);
    Show();
}


void MoveMan()
{
    static byte clock;
    constexpr byte FireInterval = CoordRate * 4 - 1;
    static byte keyCount;
    // if ((Man.status & Movable_Loose) == 0) {
        if (((Man.x | Man.y) & CoordMask) == 0) {
            byte key = ScanKeys();
            if ((key & Keys_Dir) != 0) {
                ptr<Direction> pDirection = Directions;
                ptr<byte> pKey = Keys;
                repeat (4) {
                    if ((key & *pKey) != 0) {
                        if (CanMove(&Man, pDirection->dx, pDirection->dy)) {
                            pManDirection = pDirection;
                            goto move;
                        }
                        else if (CanMove(&Man, pManDirection->dx, pManDirection->dy)) {
                            goto move;
                        }
                    }
                    ++pDirection;
                    ++pKey;
                }
            }
            Man.dx = 0;
            Man.dy = 0;
            goto button;
            move:;
            SetDirection(&Man, pManDirection);
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
        MoveMovable(&Man);
        if (IsOnGrid(&Man)) {
            byte column = ToGrid(Man.x);
            byte row = ToGrid(Man.y);
            byte cell = GetCell(column, row);
            if ((cell & (Cell_Dot | Cell_Food)) == 0) {
                SetCell(column, row, cell | Cell_Dot);
                AddScore(1);
            }
        }
    // }
    // else {
    //     if ((clock & CoordMask) == 0) {
    //         Man.status += 2;
    //         if ((Man.status & Movable_Pattern) == 0) {
    //             Man.status = Man.status & ~Movable_Loose;
    //         }
    //     }
    // }
    Show();
    ++clock;
}


// void FreezeMan()
// {
//     Man.status = (Man.status & ~Movable_Pattern) | (Movable_Loose | Movable_Live);
//     Sound_Stole();
// }


void LooseMan()
{
    byte i;
    i = 0;
    do {
        ShowSprite(&Man, ManChars + ((i & 3) << 3));
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
}
