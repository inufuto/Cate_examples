#include "Car.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Stages.h"
#include "Vram.h"
#include "Item.h"
#include "Man.h"
#include "Main.h"
#include "Monster.h"

extern void _deb();

constexpr byte Car_OverLeft = 0x80;
constexpr byte RangeX = (MapWidth * 2 - 1) * CoordRate;
constexpr byte RangeY = (MapHeight * 2 - 1) * CoordRate;

Actor[MaxCarCount] Cars;
ptr<Actor> pLostCar;

static void Show(ptr<Actor> pCar)
{
    byte pattern, status;
    status = pCar->status;
    pattern = ((status & Actor_PatternMask) << 2) + Char_Car;
    ShowSprite(&pCar->_, pattern);
}


void InitCars()
{
    ptr<byte> p;
    ptr<Actor> pCar;
    byte count, i, sprite;

    p = pStage->pCars;
    pCar = Cars;
    count = pStage->carCount;
    sprite = Sprite_Car;
    i = 0;
    while (i < count) {
        pCar->status = Actor_Live;
        pCar->_.sprite = sprite;
        LocateMovable(&pCar->_, *p); ++p;
        if (pCar->_.x < StageWidth / 2 * CoordRate) {
            SetDirection(pCar, Direction_Right);
        }
        else {
            SetDirection(pCar, Direction_Left);
        }
        Show(pCar);
        ++sprite;
        ++i;
        ++pCar;
    }
    while (i < MaxCarCount) {
        pCar->status = 0;
        pCar->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++i;
        ++pCar;
    }
    pLostCar = nullptr;
}


void MoveCars()
{
    ptr<Actor> pCar;
    for (pCar : Cars) {
        if ((pCar->status & Actor_Live) == 0) continue;
        if (IsOnCellGrid(&pCar->_)) {
            byte x, y;
            x = (pCar->_.x >> MapShift);
            y = (pCar->_.y >> MapShift);
            {
                if (x < MapWidth && y < MapHeight) {
                    byte cell;
                    cell = GetCell(x, y);
                    if ((cell & 0xc) == Cell_Arrow) {
                        byte direction;
                        direction = (cell & 3) << 1;
                        SetDirection(pCar, direction);
                        EraseCell(x, y);
                        AddScore(2);
                        Show(pCar);
                    }
                }
            }
            {
                byte nextX, nextY;
                turn:
                nextX = x + pCar->dx;
                nextY = y + pCar->dy;
                if (nextX < MapWidth && nextY < MapHeight) {
                    byte cell;
                                                _deb();
                    cell = GetCell(nextX, nextY);
                    if (cell == Cell_Wall) {
                        byte direction;
                        direction = pCar->status & Actor_DirectionMask;
                        SetDirection(pCar, direction ^ 2);
                        EraseCell(nextX, nextY);
                        AddScore(1);
                        Show(pCar);
                        goto turn;
                    }
                    else if (cell == Cell_Rock) {
                        pLostCar = pCar;
                        goto out;
                    }
                }
            }
        }
        Move(pCar);
        if (IsOnCellGrid(&pCar->_)) {
            HitItems(pCar->_.x, pCar->_.y);
            if (pCar->dx < 0) {
                if (pCar->_.x == 0) {
                    pCar->status |= Car_OverLeft;
                }
            }
        }
        if (
            pCar->_.x == -CoordRate || pCar->_.x == RangeX ||
            pCar->_.y == -CoordRate || pCar->_.y == RangeY
        ) {
            out:
            pCar->status &= ~Actor_Live;
            pLostCar = pCar;
            return;
        }
        if ((pCar->status & Actor_Live) != 0) {
            Show(pCar);
            if (IsOnCoordGrid(&pCar->_)) {
                HitMan(&pCar->_);
                HitCarMonsters(&pCar->_);
            }
        }
    }
}


void LooseCar()
{
    static const byte[] patterns = {
        Char_Car + 1 * 4,
        Char_Car + 2 * 4,
        Char_Car + 0 * 4,
        Char_Car + 3 * 4,
    };
    byte i;
    i = 0;
    do {
        ShowSprite(&pLostCar->_, patterns[i & 3]);
        DrawAll();
        // Sound_Loose();
        ++i;
    } while (i < 8);
}
