#include "GroundEnemy.h"
#include "Sprite.h"
#include "Vram.h"
#include "Chars.h"
#include "Stage.h"
#include "Math.h"
#include "Main.h"
#include "Bang.h"
#include "Sound.h"
#include "EnemyBullet.h"

extern void _deb();

constexpr byte Size = 1 * CoordRate;
constexpr byte InitialY = -CoordRate * 2;
constexpr byte RangeX = (VramWidth - 2) * CoordRate + 1;
constexpr byte RangeY = VramHeight * CoordRate;
constexpr byte InvalidY = VramHeight * CoordRate;
constexpr byte TurnMask = CoordRate * 2 - 1;

constexpr byte Type_Fixed = 0;
constexpr byte Type_Movable = 1;
constexpr byte TypeMask = 0x07;

static const word[] Points = { 3, 5 };

GroundEnemy[MaxGroundEnemyCount] GroundEnemies;

void InitGroundEnemies()
{
    byte sprite = Sprite_GroundEnemy;
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        pEnemy->sprite = sprite;
        pEnemy->y= InvalidY;
        ++sprite;
    }
}


static void Show(ptr<GroundEnemy> pEnemy)
{
    ShowSprite(pEnemy,pEnemy->type + Pattern_GroundEnemy);
}


static void End(ptr<GroundEnemy> pEnemy)
{
    pEnemy->y = InvalidY;
    HideSprite(pEnemy->sprite);
}


void StartGroundEnemy()
{
    while (GroundElementCount > 0 && pGroundElement->y == CurrentRow) {
        ptr<GroundEnemy> pEnemy;
        for (pEnemy : GroundEnemies) {
            if (pEnemy->y == InvalidY) {
                pEnemy->x = pGroundElement->x << CoordShift;
                pEnemy->y = InitialY;
                byte type;
                if (pGroundElement->routeCount != 0) {
                    type = Type_Movable;
                    pEnemy->routeCount = pGroundElement->routeCount;
                    ptr<Route> pRoute = pGroundElement->pRoute;
                    pEnemy->pRoute = pRoute;
                    pEnemy->dx = pRoute->dx;
                    pEnemy->dy = pRoute->dy;
                    pEnemy->moveCount = pRoute->count;
                }
                else {
                    type = Type_Fixed;
                }
                pEnemy->type = type;
                pEnemy->clock = 0;
                Show(pEnemy);
                break;
            }
        }
        ++pGroundElement;
        --GroundElementCount;
    }
}


void ScrollGroundEnemy()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y != InvalidY) {
            ++pEnemy->y;
            if (pEnemy->y - InitialY >= RangeY - InitialY) {
                End(pEnemy);
            }
            else {
                Show(pEnemy);
            }
        }
    }
}


void MoveGroundEnemy()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y != InvalidY) {
            ++pEnemy->clock;
            if (
                (pEnemy->clock & CoordMask) == 0 &&
                Rnd() < CurrentStage + 3
            ) {
                StartEnemyBullet(pEnemy->x, pEnemy->y);
            }
            if (pEnemy->type == Type_Fixed) continue;

            pEnemy->x += pEnemy->dx;
            pEnemy->y += pEnemy->dy;
            if (
                pEnemy->x >= RangeX || 
                pEnemy->y - InitialY >= RangeY - InitialY
            ) {
                End(pEnemy);
                continue;
            }
            else {
                Show(pEnemy);
            }

            if ((pEnemy->clock & CoordMask) == 0) {
                --pEnemy->moveCount;
                if (pEnemy->moveCount == 0) {
                    if (pEnemy->routeCount > 0) {
                        ++pEnemy->pRoute;
                        pEnemy->routeCount;
                        ptr<Route> pRoute = pEnemy->pRoute;
                        pEnemy->dx = pRoute->dx;
                        pEnemy->dy = pRoute->dy;
                        pEnemy->moveCount = pRoute->count;
                    }
                }
            }
        }
    }
}


bool HitBulletGroundEnemy(byte x, byte y)
{
    ptr<GroundEnemy> pEnemy;
    x += CoordRate - 1;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y != InvalidY) {
            if (HitEnemy(pEnemy, x, y)) {
                Sound_SmallBang();
                StartSmallBang(pEnemy->x + Size, pEnemy->y + Size);
                End(pEnemy);
                AddScore(Points[pEnemy->type]);
                return true;    
            }
        }
    }
    return false;
}
