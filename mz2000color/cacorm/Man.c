#include "Movable.h"
#include "Actor.h"
#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Main.h"
#include "Sound.h"
#include "Chars.h"
#include "Line.h"
#include "Item.h"
#include "Vram.h"
#include "Status.h"
#include "Increaser.h"
#include "VVram.h"

// constexpr byte Color = 7;

static const byte[] KeyCodes = {
    Keys_Left, Keys_Right, Keys_Up, Keys_Down
};

Actor Man;

static void Show()
{
    byte pattern;
    pattern = ((Man.status & Actor_PatternMask) << 2) + Char_Man;
    ShowSprite(&Man._, pattern);
}


void InitMan()
{
    Man._.sprite = Sprite_Man;
    Man.status = Actor_Live | Direction_Right;
    Man.dx = 0;
    Man.dy = 0;
    LocateMovable(&Man._, pStage->start);
    LineFirstX = Man._.x >> MapShift;
    LineLastX = LineFirstX;
    LinePrevX = LineLastX;
    LineFirstY = Man._.y >> MapShift;
    LineLastY = LineFirstY;
    LinePrevY = LineLastY;
    Show();
}


static bool CanMove(byte direction)
{
    ptr<sbyte> pElements;
    byte x,y;
    sbyte dx, dy;
    byte cell;
    pElements = DirectionElements + direction;
    dx = *pElements;
    ++pElements;
    dy = *pElements;
    x = (Man._.x >> MapShift) + dx;
    y = (Man._.y >> MapShift) + dy;
    if (x == LinePrevX && y == LinePrevY) return false;
    cell = GetCell(x, y);
    return (cell & Cell_Mask) == 0;
}


void MoveMan()
{
    if (((Man._.x | Man._.y) & MapMask) == 0) {
        byte key, newDirection;
        ptr<byte> pKeyCode;
        key = ScanKeys();
        newDirection = 0;
        for (pKeyCode: KeyCodes) {
            if ((key & *pKeyCode) != 0) {
                if (CanMove(newDirection)) {
                    SetDirection(&Man, newDirection);
                    goto move;
                }
                {
                    byte oldDirection;
                    oldDirection = Man.status & Actor_DirectionMask;
                    if (CanMove(oldDirection)) goto move;
                }
            }
            newDirection += 2;
        }
        stop:
        Man.dx = 0;
        Man.dy = 0;
    }
    move:
    {
        byte seq;
        Man._.x += Man.dx;
        Man._.y += Man.dy;
        seq = ((Man._.x + Man._.y + CoordRate / 2) >> CoordShift) & 1;
        Man.status = (Man.status & ~Actor_SeqMask) | seq;
    }
    Show();
    if (Man.dx != 0 || Man.dy != 0) {
        if (((Man._.x | Man._.y) & MapMask) == CoordRate) {
            GrowLeavingLine(Man.status & Actor_DirectionMask);
        }
        else if (((Man._.x | Man._.y) & MapMask) == 0) {
            GrowEnteringLine(Man.status & Actor_DirectionMask);
        }
    }
    if (IsNear(&Man._, &Increaser)) {
        HideIncreaser();
        Sound_Up();
        ++RemainCount;
        PrintStatus();
    }
}


void LooseMan()
{
    static const byte[] patterns = {
        Char_Man + 2 * 4,
        Char_Man + 4 * 4,
        Char_Man + 0 * 4,
        Char_Man + 6 * 4,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man._, patterns[i & 3]);
        DrawAll();
        Sound_Loose();
        CallSound();
        ++i;
    } while (i < 8);
}
