#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Stage.h"
#include "Sprite.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Item.h"
#include "Sound.h"
#include "Vram.h"

Actor Man;

static void Show()
{
    static const byte[] ScrollPositions = {
        -8, -7, -7, -6, -6, -5, -5, -4, -4, -3, -3, -2, -2, -1, -1, 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8
    };
    byte c;
    if (Man.dx == 0) {
        c = Man.c + 4;
    }
    else {
        c = Man.c + (Man.status & Actor_SeqMask);
    }
    HScroll = ScrollPositions[Man._.x >> 3];
    ShowSprite(&Man._, c);
}

void InitMan()
{
    byte b;
    b = pStage->manPosition;
    Man._.x = ToX(b) << CoordShift;
    Man._.y = (ToY(b) + 1) << CoordShift;
    Man._.sprite = Sprite_Man;
    Man.status = Actor_Live;
    Man.dx = 0;
    Man.c = Pattern_Man_Right;
    Show();
}


void MoveMan()
{
    if (IsOnGrid(&Man._)) {
        sbyte dx;
        byte key;
        dx = 0;
        key = ScanKeys();
        if ((key & Keys_Left) != 0) {
            dx = -1;
            Man.c = Pattern_Man_Left;
        }
        else if ((key & Keys_Right) != 0) {
            dx = 1;
            Man.c = Pattern_Man_Right;
        }
        if (dx != 0) {
            if (!CanMoveTo(&Man, dx)) {
                dx = 0;
            }
        }
        Man.dx = dx;
        HitItems();
    }
    if (Man.dx != 0) {
        byte seq;
        Man._.x += Man.dx;
        seq = ((Man._.x + CoordRate / 2) >> CoordShift) & 3;
        Man.status = (Man.status & ~Actor_SeqMask) | seq;
    }
    Show();
    ++Man._.clock;
}


void MoveManOnLift(ptr<Movable> pLift)
{
    if (MoveOnLift(&Man, pLift)) {
        Show();
    }
}


void FallMan()
{
    Fall(&Man);
    Show();
}


void HitMan(ptr<Movable> pMovable)
{
    if (IsNear(pMovable, &Man._)) {
        Man.status &= ~Actor_Live;
    }
}


void LooseMan()
{
    static const byte[] patterns = {
        Pattern_Man_Left_Stop,
        Pattern_Man_Loose + 0,
        Pattern_Man_Loose + 1,
        Pattern_Man_Loose + 2,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, patterns[i & 3]);
        UpdateSprites();
        Sound_Loose();
        ++i;
    } while (i < 8);
    Man.status &= ~Actor_Live;
}
