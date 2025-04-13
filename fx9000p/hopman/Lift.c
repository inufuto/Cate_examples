#include "Lift.h"
#include "Stages.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Man.h"

extern void _deb();

constexpr byte InvalidPosition = 0xff;

Lift[MaxLiftCount] Lifts;

static void Show(ptr<Lift> pLift)
{
    ShowSprite(&pLift->_, pLift->pattern);
}

void InitLifts()
{
    byte i, n;
    ptr<byte> pByte;
    ptr<Lift> pLift;
    byte sprite;
    i = 0;
    n = pStage->liftCount;
    pByte = pStage->pLifts;
    pLift = Lifts;
    sprite = Sprite_Lift;
    while (i < n) {
        byte b, direction, column, floor, length;
        b = *pByte; ++pByte;
        column = *pByte; ++pByte;
        pLift->_.x = ColumnToX(column);
        floor = b & 0x03;
        pLift->_.y = FloorToY(floor) + Offset_Foot;
        direction = b & 0x80;
        length = (b & 0x78) >> 3;
        if (direction == 0) {
            // HORIZONTAL
            pLift->leftTop = pLift->_.x;
            pLift->rightBottom = ColumnToX(column + length);
            pLift->dx = 1;
            pLift->dy = 0;
            pLift->pattern = Char_Lift_Right;
        }
        else {
            // VERTICAL
            pLift->leftTop = pLift->_.y;
            pLift->rightBottom = pLift->_.y + (length << FloorShift);
            pLift->dx = 0;
            pLift->dy = 1;
            pLift->pattern = Char_Lift_Down;
        }
        pLift->_.sprite = sprite;
        Show(pLift);
        ++pLift;
        ++sprite;
        ++i;
    }
    while (i < MaxLiftCount) {
        pLift->leftTop = InvalidPosition;
        ++pLift;
        ++i;
    }
}


void MoveLifts()
{
    ptr<Lift> pLift;
    bool scroll;
    scroll = false;
    for (pLift: Lifts) {
        if (pLift->leftTop != InvalidPosition) {
            byte oldY;
            sbyte oldDx;
            oldY = pLift->_.y;
            oldDx = pLift->dx;
            if (pLift->dx == 0) {
                if (pLift->dy > 0) {
                    ++pLift->_.y;
                    if (pLift->_.y == pLift->rightBottom) {
                        pLift->dy = -1;
                        pLift->pattern = Char_Lift_Up;
                    }
                }
                else {
                    --pLift->_.y;
                    if (pLift->_.y == pLift->leftTop) {
                        pLift->dy = 1;
                        pLift->pattern = Char_Lift_Down;
                    }
                }
            }
            else {
                if (pLift->dx > 0) {
                    if (MoveX(&pLift->_, pLift->dx)) {
                        if (pLift->_.x == pLift->rightBottom) {
                            pLift->dx = -1;
                            pLift->pattern = Char_Lift_Left;
                        }
                    }
                }
                else {
                    if (MoveX(&pLift->_, pLift->dx)) {
                        if (pLift->_.x == pLift->leftTop) {
                            pLift->dx = 1;
                            pLift->pattern = Char_Lift_Right;
                        }
                    }
                }
            }
            if (MoveManOnLift(&pLift->_, oldDx, oldY)) {
                Man.dy = 0;
                Man.status &= ~Man_Jump;
                scroll = true;
            }
            Show(pLift);
        }
    }
    if (scroll) {
        Scroll();
    }
}


bool IsManOnAnyLift()
{
    ptr<Lift> pLift;
    for (pLift: Lifts) {
        if (pLift->leftTop != InvalidPosition) {
            if (IsManOnLift(pLift->_.x, pLift->_.y)) {
                return true;
            }
        }
    }
    return false;
}


ptr<Lift> FindLift(ptr<Movable> pMovable, byte nextY)
{
    ptr<Lift> pLift;
    for (pLift: Lifts) {
        if (pLift->leftTop != InvalidPosition) {
            if (IsNexrX(pLift->_.x, pMovable->x)) {
                byte top;
                top = pLift->_.y - 2;
                if (top >= pMovable->y && nextY >= top) {
                    return pLift;
                }
            }
        }
    }
    return nullptr;
}
