#include "Movable.h"
#include "Man.h"
#include "Sprite.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Block.h"
#include "Sound.h"
#include "Main.h"
#include "Chars.h"
#include "Vram.h"

static const byte[] KeyCodes = {
    Keys_Left, Keys_Right, Keys_Up, Keys_Down
};

Movable Man;


static void Show()
{
    byte pattern;
    if ((Man.status & Movable_Pushing) != 0) {
        pattern = ((Man.status & Movable_PatternMask) >> 1) + Pattern_Man + 8;
    }
    else {
        pattern = ((Man.status & Movable_PatternMask)) + Pattern_Man;
    }
    ShowSprite(&Man, pattern);
}


void InitMan()
{
    Man.sprite = Sprite_Man;
    Man.status = Movable_Live | Direction_Right;
    Man.dx = 0;
    Man.dy = 0;
    LocateMovableB(&Man, pStage->start);
    Show();
}


void MoveMan()
{
    if ((Man.status & Movable_Pushing) != 0) {
        ++Man.clock;
        if (Man.clock >= CoordRate) {
            Man.status &= ~Movable_Pushing;
        }
    }
    if (IsOnGrid(&Man)) {
        byte key, direction;
        ptr<byte> pKeyCode;

        key = ScanKeys();
        direction = 0;
        for (pKeyCode: KeyCodes) {
            if ((key & *pKeyCode) != 0) {
                byte cell;
                cell = NextCellOrMovable(&Man, direction);
                if (cell >= Cell_Wall) {
                    byte oldDirection;
                    oldDirection = Man.status & Movable_DirectionMask;
                    cell = NextCellOrMovable(&Man, oldDirection);
                    if (cell == Cell_None) goto move;
                }
                SetDirection(&Man, direction);
                if (cell == Cell_None) goto move;
                goto stop;
            }
            direction += 2;
        }
        stop:
        Man.dx = 0;
        Man.dy = 0;
        move:
        if ((key & Keys_Button0) != 0) {
            if (PushBlock(&Man)) {
                Man.clock = 0;
                AddScore(1);
                Sound_Push();
            }
        }
    }
    {
        byte seq;
        Man.x += Man.dx;
        Man.y += Man.dy;
        seq = ((Man.x + Man.y + CoordRate / 2) >> CoordShift) & 1;
        Man.status = (Man.status & ~Movable_SeqMask) | seq;
    }
    Show();
}


bool IsNearMan(ptr<Movable> pMovable, byte x, byte y)
{
    if (pMovable != &Man) {
        byte thisX, thisY;
        thisX = Man.x >> MapShift;
        thisY = Man.y >> MapShift;
        if (x == thisX && y == thisY) return true;
        if (!IsOnGrid(&Man)) {
            thisX += Man.dx;
            thisY += Man.dy;
            if (x == thisX && y == thisY) return true;
        }
    }
    return false;
}


bool HitMan(ptr<Movable> pBlock)
{
    if (
        (Man.status & Movable_Live) != 0 &&
        IsNear(pBlock, &Man)
    ) {
        Sound_Loose();
        Man.status &= ~Movable_Live;
        return true;
    }
    return false;
}


void LooseMan()
{
    static const byte[] patterns = {
        Pattern_Man + 2,
        Pattern_Man + 4,
        Pattern_Man + 0,
        Pattern_Man + 6,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&Man, patterns[i & 3]);
        DrawAll();
        Sound_Loose();
        ++i;
    } while (i < 8);
}
