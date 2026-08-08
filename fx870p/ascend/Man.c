#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Man.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Block.h"
#include "Sound.h"
#include "Main.h"
#include "Fire.h"
#include "Status.h"
#include "VVram.h"

static const byte[] JumpHeights = {
    1, 3, 4, 5, 6, 7, 8, 8, 8, 8, 7, 6, 5, 4, 3, 1,    
};

Actor Man;
byte JumpSeq;
byte PowerTime;
static byte MinY;
static byte oldKeyX, oldKeyY;

constexpr byte Char_Man_Left = 0 * 4;
constexpr byte Char_Man_Left0 = Char_Man_Left + 4;
constexpr byte Char_Man_Right = 3 * 4;
constexpr byte Char_Man_Climb = 6 * 4;

extern void _deb();
void ShowMan()
{
    byte pattern;
    pattern = Man.pattern;
    if (Man.pattern != Char_Man_Climb && Man.dx != 0) {
        constexpr byte Horizontal = Char_Man_Left0 - Char_Man_Left;
        byte seq;
        seq = Man.status & Actor_SeqMask;
        pattern = pattern + Horizontal + (seq << 2);
    }
    if (PowerTime == 0 || (PowerTime & 0x02) == 0) {
        static const byte[] Chars = {
            0xf0, 0x00, 0x60, 0x40, 0xf0, 0x40, 0x60, 0x10,
	        0xf0, 0x00, 0x30, 0x40, 0x00, 0xf0, 0x10, 0x90,
	        0x10, 0xf0, 0x40, 0x90, 0x00, 0xf0, 0x10, 0xc0,
	        0x70, 0xd0, 0x60, 0x90,
        };
        if ((Man.status & Man_Jump) == 0) {
            ShowSprite(&Man._, Chars + pattern);
        }
        else {
            --Man._.y;
            ShowSprite(&Man._, Chars + pattern);
            ++Man._.y;
        }
    }
    else {
        HideSprite(Man._.sprite);
    }
}


void InitMan()
{
    byte height;
    height = pStage->height;
    Man._.x = 0;
    Man._.y = (height << 2) + Overhead;
    Man._.sprite = Sprite_Man;
    Man.status = Actor_Live;
    Man.dx = 0;
    Man.dy = 0;
    Man.pattern = Char_Man_Right;
    PowerTime = 0;
    MinY = Man._.y;
    oldKeyX = 0;
    oldKeyY = 0;
    ShowMan();
}


static bool TestMoveX(byte key)
{
    sbyte dx;
    dx = 0;
    if (
        IsOnFloor(Man._.y) ||
        GetCellType(Man._.x, Man._.y + 2) != CellType_Ladder
    ) {
        if (
            (key & Keys_Left) != 0 &&
            CanMove(&Man, -1)
        ) {
            dx = -1;
            Man.pattern = Char_Man_Left;
        }
        else if (
            (key & Keys_Right) != 0 &&
            CanMove(&Man, 1)
        ) {
            dx = 1;
            Man.pattern = Char_Man_Right;
        }
    }
    Man.dx = dx;
    return Man.dx != 0;
}

static bool TestMoveY(byte key)
{
    if ((Man.status & (Man_Fall | Man_Jump)) == 0) {
        sbyte dy;
        dy = 0;
        if ((Man.status & Man_Jump) == 0) {
            if ((Man._.x & 1) == 0) {
                if ((key & Keys_Up) != 0) {
                    if (IsOnFloor(Man._.y)) {
                        if (GetCellType(Man._.x, Man._.y + 2) == CellType_Ladder) {
                            up:
                            dy = -1;
                            Man.dx = 0;
                            Man.pattern = Char_Man_Climb;
                        }
                    }
                    else {
                        if (
                            GetCellType(Man._.x, Man._.y + 2) == CellType_Ladder ||
                            GetCellType(Man._.x, Man._.y + FloorHeight) == CellType_Ladder
                        )
                        goto up;
                    }
                }
                else if ((key & Keys_Down) != 0) {
                    if (IsOnFloor(Man._.y)) {
                        if (GetCellType(Man._.x, Man._.y + FloorHeight) == CellType_Ladder) {
                            down:
                            dy = 1;
                            Man.dx = 0;
                            Man.pattern = Char_Man_Climb;
                        }
                    }
                    else {
                        if (
                            GetCellType(Man._.x, Man._.y + 2) == CellType_Ladder // ||
                        )
                        goto down;
                    }
                }
            }
        }
        Man.dy = dy;
    }
    return Man.dy != 0;
}

void MoveMan()
{
    byte key, keyX, keyY;
    if ((Man.status & Actor_Live) == 0) return;
    key = ScanKeys();
    keyX = key & Keys_DirX;
    if ((key & Keys_Dir) != 0) {
        if (TestMoveX(keyX)) {
            oldKeyX = keyX;
            oldKeyY = 0;
            goto moved;
        }
        else {
            if (oldKeyX != 0) {
                if (TestMoveX(oldKeyX)) {
                    oldKeyY = 0;
                }
            }
        }
        keyY = key & Keys_DirY;
        if (TestMoveY(keyY)) {
            oldKeyY = keyY;
            oldKeyX = 0;
        }
        else {
            if (oldKeyY != 0) {
                if (TestMoveY(oldKeyY)) {
                    oldKeyX = 0;
                }
            }
        }
    }
    else {
        Man.dx = 0;
        Man.dy = 0;
        // oldKeyX = 0;
        // oldKeyY = 0;
    }
    moved:
    if ((Man.status & (Man_Fall | Man_Jump)) == 0) {
        if (
            (key & Keys_Button0) != 0 &&
            IsOnFloor(Man._.y) &&
            Man.dy == 0
        ) {
            Man.status |= Man_Jump;
            JumpSeq = 0;
        }
    }
    MoveActor(&Man);
    if (Man.dy != 0) {
        Scroll();
    } 
    else if ((Man.status & Man_Jump) != 0) {
        ++JumpSeq;
        if (JumpSeq < CoordRate * 2 + 1) {
            HitUnderBlock();
        }
        else {
            HitOverBlock();
            Man.status &= ~Man_Jump;
        }
    }
    while (MinY > Man._.y) {
        AddScore(1);
        --MinY;
    }
    exit:
    ShowMan();
}


void FallMan()
{
    if ((Man.status & Man_Jump) == 0) {
        if (IsOnFloor(Man._.y)) {
            if (
                (Man._.x & 1) == 0 && 
                GetCellType(Man._.x, Man._.y) == CellType_Hole
            ) goto fall;
            goto stop;
        }
        else if (
            GetCellType(Man._.x, Man._.y + 2) != CellType_Ladder
        ) {
            fall:
            Man.status |= Man_Fall;
            Man.dy = 1;
        }
        else {
            stop:
            Man.status &= ~Man_Fall;
            Man.dy = 0;
        }
    }
    if ((Man.status & Man_Fall) != 0) {
        MoveActorY(&Man);
        Scroll();
    }
}


void Scroll()
{
    byte y, newTopY, newOffset, t;
    y = Man._.y;
    newTopY = y - (WindowHeight / 2) - FloorHeight;
    if (newTopY != topY && newTopY < topYRange) {
        topY = newTopY;
        DrawBackground();
        return;
    }
}


void HitMan(ptr<Actor> pActor)
{
    if (IsNearXY(&pActor->_, &Man._)) {
        if ((pActor->status & Item_1Up) != 0) {
            if (RemainCount < 10) {
                ++RemainCount;
                PrintStatus();
                Sound_Item();
                goto get;
            }
        }
        else if ((pActor->status & Item_Power) != 0) {
            PowerTime = 100 - CurrentStage;
            AddScore(10);
            Sound_Item();
            get:
            pActor->status &= ~Actor_Live;
            HideSprite(pActor->_.sprite);
        } 
        else if (PowerTime == 0) {
            Man.status &= ~Actor_Live;
        }
    }
}


void LooseMan()
{
    static const byte[] Chars = {
        0xf0, 0x00, 0x60, 0x40,
        0x00, 0x10, 0xf0, 0x90,
	    0x20, 0x60, 0x00, 0xf0,
        0x90, 0xf0, 0x80, 0x00,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, Chars + ((i & 3) << 2));
        // UpdateSprites();
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
    Man.status &= ~Actor_Live;
}
