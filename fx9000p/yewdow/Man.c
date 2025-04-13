#include "Man.h"
#include "ScanKeys.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Actor.h"
#include "Vram.h"
#include "Monster.h"

extern void _deb();

constexpr byte Man_ButtonOn = 0x40;
constexpr byte Man_ArrowOn = 0x20;
constexpr byte Man_Flash = 0x80;
constexpr byte FreezeTime = 20 * CoordRate;

static const byte[] KeyCodes = {
    Keys_Left, Keys_Right, Keys_Up, Keys_Down
};

Actor Man;
static byte ArrowX, ArrowY;

static void Show()
{
    byte status, pattern;
    status = Man.status;
    if ((status & Man_Flash) != 0) {
        pattern = Char_Arrow_Null;
        Man.status &= ~Man_Flash;
    }
    else {
        pattern = ((status & Actor_PatternMask) << 2) + Char_Man;
    }
    ShowSprite(&Man._, pattern);
}


void InitMan()
{
    Man._.sprite = Sprite_Man;
    Man.status = Actor_Live | Direction_Right;
    Man.dx = 0;
    Man.dy = 0;
    LocateMovable(&Man._, pStage->start);
    Show();
}


void MoveMan()
{
    if ((Man.status & Actor_Live) != 0) {
        byte key;
        key = ScanKeys();
        if (IsOnCellGrid(&Man._)) {
            byte newDirection;
            ptr<byte> pKeyCode;
            newDirection = 0;
            for (pKeyCode: KeyCodes) {
                if ((key & *pKeyCode) != 0) {
                    if (CanMove(&Man, newDirection)) {
                        SetDirection(&Man, newDirection);
                        goto move;
                    }
                    {
                        byte oldDirection;
                        oldDirection = Man.status & Actor_DirectionMask;
                        if (CanMove(&Man,oldDirection)) goto move;
                    }
                }
                newDirection += 2;
            }
            stop:
            Man.dx = 0;
            Man.dy = 0;
            move:
            if ((key & Keys_Button0) != 0 && (Man.status & (Man_ButtonOn | Man_ArrowOn)) == 0) {
                byte x, y;
                Man.status |= Man_ButtonOn;
                x = Man._.x >> CoordShift;
                y = Man._.y >> CoordShift;
                if (GetCell(x >> 1, y >> 1) == Cell_Space) {
                    ArrowX = x;
                    ArrowY = y;
                    Man.status |= Man_ArrowOn | Man_Flash;
                    // Put2CXY(x, y + StatusHeight, Char_Arrow_Null);
                    // Sound_Beep();
                }
            }
        }
        else if ((Man.status & Man_ArrowOn) != 0) {
            byte direction;
            Man.status &= ~Man_ArrowOn;
            direction = Man.status & Actor_DirectionMask;
            SetCell(ArrowX >> 1, ArrowY >> 1, (direction >> 1) | Cell_Arrow);
            // Put2CXY(ArrowX, ArrowY + StatusHeight, (direction << 1) + Char_Arrow);
        }
        if ((key & Keys_Button0) == 0) {
            Man.status &= ~Man_ButtonOn;
        }
        Move(&Man);
        Show();
        if (IsOnCoordGrid(&Man._)) {
            HitManMonsters();
        }
    }
    else {
        if ((Man.clock & CoordMask) == 0) {
            static const byte[] patterns = {
                Char_Man + 0 * 4,
                Char_Man + 4 * 4,
                Char_Man + 2 * 4,
                Char_Man + 6 * 4,
            };
            byte pattern;
            pattern = patterns[(Man.clock >> CoordShift) & 3];
            ShowSprite(&Man._, pattern);
        }
        --Man.clock;
        if (Man.clock == 0) {
            Man.status |= Actor_Live;
            Show();
        }
    }
}


bool HitMan(ptr<Movable> pMovable)
{
    if ((Man.status & Actor_Live) != 0 && IsNear(pMovable, &Man._)) {
        Man.status &= ~Actor_Live;
        Man.clock = FreezeTime;
        // Sound_Freeze();
        return true;
    }
    return false;
}