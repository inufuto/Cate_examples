#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Man.h"
#include "Stage.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Vram.h"
#include "Block.h"
#include "Sound.h"
#include "Main.h"
#include "Fire.h"
#include "Status.h"
#include "VVram.h"

static const byte[] JumpHeights = {
    1, 2, 3, 4, 4, 3, 2, 1,
};

Actor Man;
byte JumpSeq;
byte PowerTime;
static byte MinY;
 byte oldKeyX, oldKeyY;

extern void _deb();
void ShowMan()
{
    byte pattern;
    if (Man.dy == 0) {
        if (Man.dx == 0) {
            pattern = Man.pattern;
        }
        else {
            constexpr byte Horizontal = Pattern_Man_Left0 - Pattern_Man_Left;
            byte seq;
            seq = Man.status & Actor_SeqMask;
            if (seq == 3) {
                seq = 1;
            }
            pattern = Man.pattern + Horizontal + seq;
        }
    }
    else {
        byte seq;
        seq = Man.status & 1;
        pattern = Man.pattern + seq;
    }
    if (PowerTime == 0 || (PowerTime & 0x01) == 0) {
        ShowSprite(&Man._, pattern);
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
    Man._.xd = 0;
    Man._.y = (height << 2) + Overhead;
    Man._.yd = 0;
    Man._.sprite = Sprite_Man;
    Man.status = Actor_Live;
    Man.dx = 0;
    Man.dy = 0;
    Man.pattern = Pattern_Man_Right;
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
        (
            Man._.yd == 0 ||
            (Man.status & (Man_Fall | Man_Jump)) != 0
        ) && (
            IsOnFloor(Man._.y) ||
            GetCellType(Man._.x, Man._.y + 2) != CellType_Ladder
        )
    ) {
        if (
            (key & Keys_Left) != 0 &&
            CanMove(&Man, -1)
        ) {
            dx = -1;
            Man.pattern = Pattern_Man_Left;
        }
        else if (
            (key & Keys_Right) != 0 &&
            CanMove(&Man, 1)
        ) {
            dx = 1;
            Man.pattern = Pattern_Man_Right;
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
                            Man.pattern = Pattern_Man_Climb;
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
                            Man.pattern = Pattern_Man_Climb;
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
    if (Man._.xd == 0) {
        byte key, keyX, keyY;
        key = ScanKeys();
        keyX = key & Keys_DirX;
        if ((key & Keys_Dir) != 0) {
            if (keyX != 0 && TestMoveX(keyX)) {
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
            if ((Man._.yd & CoordMask) == 0) {
                keyY = key & Keys_DirY;
                if (keyY != 0 && TestMoveY(keyY)) {
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
        }
        else {
            Man.dx = 0;
            // oldKeyX = 0;
            if ((Man._.yd & CoordMask) == 0) {
                Man.dy = 0;
                // oldKeyY = 0;
            }
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
    }
    MoveActor(&Man);
    if (Man.dy != 0) {
        Scroll();
    } 
    else if ((Man.status & Man_Jump) != 0) {
        ++JumpSeq;
        if (JumpSeq < CoordRate * 2) {
            Man._.yd = -JumpHeights[JumpSeq];
        }
        else {
            Man.status &= ~Man_Jump;
            Man._.yd = 0;
        }
        if (JumpSeq < CoordRate) {
            HitUnderBlock();
        }
        else {
            HitOverBlock();
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
    if (
        (Man.status & Man_Jump) == 0 &&
        Man._.yd == 0
    ) {
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
    }
}


void Scroll()
{
    byte y, newTopY, newOffset, t;
    y = Man._.y;
    if (Man._.yd != 0) {
        ++y;
    }
    newTopY = y - (VVramHeight / 2) - FloorHeight;
    if (newTopY != topY && newTopY < topYRange) {
        topY = newTopY;
        dotOffset = (8 - Man._.yd) & CoordMask;
        DrawBackground();
        return;
    }
    if (topY == 0) return;
    if (newTopY >= topYRange || Man._.yd == 0) return;

    newOffset = (8 - Man._.yd) & CoordMask;
    if (dotOffset != newOffset) {
        dotOffset = newOffset;
        DrawBackground();
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
    static const byte[] patterns = {
        Pattern_Man_Left_Stop,
        Pattern_Man_Loose0,
        Pattern_Man_Loose1,
        Pattern_Man_Loose2,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, patterns[i & 3]);
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
    Man.status &= ~Actor_Live;
}
