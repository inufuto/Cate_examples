#include "Man.h"
#include "Sprite.h"
#include "Chars.h"
#include "ScanKeys.h"
#include "Stage.h"
#include "VVram.h"
#include "Sound.h"
#include "Main.h"
#include "Vram.h"

const ManDirection[] Directions = {
    { -1, 0, Direction_Left * 2, Keys_Left },
    { 1, 0, Direction_Right * 2, Keys_Right },
    { 0, -1, Direction_Up * 2, Keys_Up },
    { 0, 1, Direction_Down * 2, Keys_Down },
};

Man Man;
static bool keyOn;

static void Show()
{
    byte pattern = Man.status & Movable_PatternMask;
    byte seq = ((Man.x + Man.y) >> CoordShift) & 1;
    pattern += seq;
    ShowSprite(&Man, Char_Man + (pattern << 2));
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
    if ((Man.status & Movable_OnPanel) != 0) return;
    if (((Man.x | Man.y) & CoordMask) == 0) {
        byte key = ScanKeys();
        if ((key & Keys_Dir) != 0) {
            ptr<ManDirection> pDirection = Directions;
            repeat (4) {
                if ((key & pDirection->key ) != 0) {
                    if (CanMoveMovable(&Man, pDirection->dx, pDirection->dy)) {
                        Man.pDirection = pDirection;
                        goto move;
                    }
                    else {
                        ptr<ManDirection> pOldDirection = Man.pDirection;
                        if (CanMoveMovable(&Man, pOldDirection->dx, pOldDirection->dy)) {
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
            Man.status = (Man.status & ~Movable_PatternMask) | pDirection->pattern;
        }
        button:
        if ((key & Keys_Button0) != 0) {
            if (!keyOn) {
                StartMovingPanel();
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
        byte x = Man.x >> CoordShift;
        byte xMod = x & 3;
        byte y = Man.y >> CoordShift;
        byte yMod = y & 3;
        if (xMod == 1 && yMod == 1) {
            byte column = x >> 2;
            byte row = y >> 2;
            ptr<byte> pMap = MapPtr(column, row);
            if ((*pMap & Panel_Star) != 0) {
                *pMap &= ~Panel_Star;
                word vram = VramAddress(x, y + StageTop);
                Erase2(vram);
                AddScore(5);
                --StarCount;
                Sound_Hit();
            }
        }
    }
}


void SlideMan(sbyte dx, sbyte dy)
{
    Man.x += dx;
    Man.y += dy;
    Show();
}


void LooseMan()
{
    static const byte[] patterns = {
        Char_Man_Left,
        Char_Man_Down,
        Char_Man_Right,
        Char_Man_Up,
    };
    byte i = 0;
    do {
        ShowSprite(&Man, patterns[i & 3]);
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
}


void SkipKey()
{
    if ((ScanKeys() & Keys_Button0) == 0) {
        keyOn = false;
    }
}