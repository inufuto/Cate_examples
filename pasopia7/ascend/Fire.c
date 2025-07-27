#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Fire.h"
#include "Chars.h"
#include "Math.h"
#include "Main.h"
#include "Stage.h"
#include "Man.h"
#include "Vram.h"
#include "VVram.h"

constexpr byte MaxCount = Sprite_Monster - Sprite_Fire;
constexpr byte Interval = 100;

Actor[MaxCount] Fires;
static sbyte spawnCount;
static byte spawnRate;

extern void _deb();
void InitFires()
{
    byte sprite;
    ptr<Actor> pFire;
    sprite = Sprite_Fire;
    for (pFire : Fires) {
        pFire->status = 0;
        pFire->_.sprite = sprite;
        ++sprite;
    }
    spawnCount = -Interval;
    spawnRate = 2 + (pStage->height >> 1);
}


void StartFire()
{
    spawnCount += spawnRate;
    if (spawnCount > 0) {
        byte x, y, cell;
        y = topY & 0x03;
        x = (Rnd() & 0x0f) << 1;
        cell = GetCellType(x, y);
        if (
            GetCellType(x, y) != CellType_Wall &&
            GetCellType(x, y + FloorHeight) != CellType_Ladder
        ) {
            ptr<Actor> pFire;
            for (pFire : Fires) {
                if ((pFire->status & Actor_Live) == 0) {
                    pFire->_.x = x;
                    pFire->_.y = y;
                    pFire->dx = 0;
                    pFire->dy = 1;
                    pFire->pattern = Char_Fire;
                    pFire->status = Actor_Live;
                    if ((Rnd() & 0x07) == 0) {
                        pFire->status |= Item_Power;
                    }
                    else if ((Rnd() & 0x0f) == 0) {
                        pFire->status |= Item_1Up;
                    }
                    ShowEnemy(pFire);
                    spawnCount -= Interval;
                    return;
                }
            }
        }
    }
}


void MoveFires()
{
    ptr<Actor> pFire;
    for (pFire : Fires) {
        if ((pFire->status & Actor_Live) != 0) {
            HitMan(pFire);
            if (IsOnFloor(pFire->_.y)) {
                if ((pFire->_.x & 1) == 0 && (
                    GetCellType(pFire->_.x, pFire->_.y) == CellType_Hole ||
                    GetCellType(pFire->_.x, pFire->_.y + FloorHeight) == CellType_Ladder
                )) {
                    pFire->dx = 0;
                    pFire->dy = 1;
                }
                else {
                    pFire->dy = 0;
                    if (pFire->dx == 0) {
                        pFire->dx = Sign(Man._.x, pFire->_.x);
                    }
                    if (pFire->dx == 0) {
                        pFire->dx = Sign(StageWidth / 2, pFire->_.x);
                    }
                    if (pFire->dx < 0) {
                        if (!CanMove(pFire, -1)) {
                            pFire->dx = 1;
                            pFire->pattern = Char_Fire_Right;
                        }
                        else {
                            pFire->pattern = Char_Fire_Left;
                        }
                    }
                    else if (pFire->dx > 0) {
                        if (!CanMove(pFire, 1)) {
                            pFire->dx = -1;
                            pFire->pattern = Char_Fire_Left;
                        }
                        else {
                            pFire->pattern = Char_Fire_Right;
                        }
                    }
                }
            }
            MoveActor(pFire);
            if (pFire->_.y > topY && pFire->_.y - topY >= WindowHeight) {
                pFire->status = 0;
                HideSprite(pFire->_.sprite);
            }
            else {
                if ((pFire->status & Item_1Up) != 0) {
                    ShowSprite(&pFire->_, Char_Item_1Up);
                }
                else if ((pFire->status & Item_Power) != 0) {
                    ShowSprite(&pFire->_, Char_Item_Power);
                }
                else {
                    ShowEnemy(pFire);
                }
                HitMan(pFire);
            }
        }
    }
}
