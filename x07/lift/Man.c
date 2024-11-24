#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Stage.h"
#include "Sprite.h"
#include "ScanKeys.h"
#include "Item.h"
#include "Sound.h"
#include "VVram.h"

constexpr byte Char_Man_Left = 0;
constexpr byte Char_Man_Right = 3 * 4;

Actor Man;

static void Show()
{
    const byte[] Chars = {
        0xf0, 0x20, 0x60, 0x10, 0xf0, 0x00, 0x50, 0x20,
	    0xf0, 0x00, 0x60, 0x20, 0x10, 0xf0, 0x20, 0x90,
	    0x00, 0xf0, 0x10, 0xa0, 0x00, 0xf0, 0x10, 0x90,    
    };
    byte c;
    if (Man.dx == 0) {
        c = Man.c + 2 * 4;
    }
    else {
        c = Man.c + ((Man.status & Actor_SeqMask) << 2);
    }
    ShowSprite(&Man._, Chars + c);
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
    Man.c = Char_Man_Right;
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
            Man.c = Char_Man_Left;
        }
        else if ((key & Keys_Right) != 0) {
            dx = 1;
            Man.c = Char_Man_Right;
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
        seq = ((Man._.x + CoordRate / 2) >> CoordShift) & 1;
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
    static const byte[] Chars = {
        0xf0, 0x00, 0x60, 0x20, 0x40, 0x60, 0x00, 0xf0,
	    0x90, 0xf0, 0x80, 0x00, 0xd0, 0xd0, 0xd0, 0xb0,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, Chars + (i & 3));
        // UpdateSprites();
        Sound_Loose();
        DrawAll();
        ++i;
    } while (i < 8);
    Man.status &= ~Actor_Live;
}
