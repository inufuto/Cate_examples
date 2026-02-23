#include "Stage.h"
#include "GroundEnemy.h"
#include "Sprite.h"
#include "VVram.h"
#include "Math.h"
#include "Main.h"
#include "EnemyBullet.h"
#include "Bang.h"
#include "Main.h"
#include "Sound.h"


constexpr byte Size = 1 * CoordRate;
constexpr byte Count = Sprite_FighterBullet - Sprite_GroundEnemy;
constexpr byte RangeX = VVramWidth * CoordRate - 1;
constexpr byte RangeY = VVramHeight * CoordRate;
constexpr byte InvalidY = 0xff;
constexpr byte HitMask = CoordMask >> 1;

// constexpr byte Color = 14;
constexpr byte Type_Fixed = 0;
constexpr byte Type_Movable = 1;

static const word[] Points = { 3, 5 };
static const word[] Patterns = {
    GChar_GroundEnemyA,
    GChar_GroundEnemyB,
};
GroundEnemy[Count] GroundEnemies;


void InitGroundEnemies()
{
    byte sprite;
    ptr<GroundEnemy> pEnemy;
    sprite = Sprite_GroundEnemy;
    for (pEnemy : GroundEnemies) {
        pEnemy->sprite = sprite;
        pEnemy->y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<GroundEnemy> pEnemy)
{
    ShowSprite(
        pEnemy->sprite, pEnemy->x, pEnemy->y, 
        Patterns[pEnemy->type]
    );
}


static void End(ptr<GroundEnemy> pEnemy)
{
    pEnemy->y = InvalidY;
    HideSprite(pEnemy->sprite);
}


void StartGroundEnemy()
{
    // byte y;
    // y = topRow + TileSize;
    while (groundElementCount > 0 && pGroundElement->y == topRow) {
        ptr<GroundEnemy> pEnemy;
        for (pEnemy : GroundEnemies) {
            if (pEnemy->y >= RangeY) {
                pEnemy->x = pGroundElement->x << CoordShift;
                pEnemy->y = (pGroundElement->y - topRow) << CoordShift;
                if (pGroundElement->routeCount > 0) {
                    ptr<Route> pRoute;
                    pEnemy->type = Type_Movable;
                    pEnemy->routeCount = pGroundElement->routeCount;
                    pRoute = pGroundElement->pRoute;
                    pEnemy->pRoute = pRoute;
                    pEnemy->dx = pRoute->dx;
                    pEnemy->dy = pRoute->dy;
                    pEnemy->moveCount = pRoute->count;
                }
                else {
                    pEnemy->type = Type_Fixed;
                }
                pEnemy->clock = 0;
                Show(pEnemy);
                break;
            }
        }
        ++pGroundElement;
        --groundElementCount;
    }
}


void ScrollGroundEnemy()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y >= RangeY) continue;
        ++pEnemy->y;
        if (pEnemy->y >= RangeX) {
            End(pEnemy);
        }
        else {
            Show(pEnemy);
        }
    }
}


void MoveGroundEnemy()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y >= RangeY) continue;

        ++pEnemy->clock;
        if (
            (pEnemy->clock & CoordMask) == 0 &&
            Rnd() < CurrentStage + 1
        ) {
            StartEnemyBullet(pEnemy->x, pEnemy->y);
        }
        if (pEnemy->type == Type_Fixed) continue;

        pEnemy->x += pEnemy->dx;
        pEnemy->y += pEnemy->dy;
        if (pEnemy->x >= RangeX || pEnemy->y >= RangeY) {
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
                    ptr<Route> pRoute;
                    ++pEnemy->pRoute;
                    pEnemy->routeCount;
                    pRoute = pEnemy->pRoute;
                    pEnemy->dx = pRoute->dx;
                    pEnemy->dy = pRoute->dy;
                    pEnemy->moveCount = pRoute->count;
                }
            }
        }
    }
}


static void Destroy(ptr<GroundEnemy> pEnemy)
{
    Sound_SmallBang();
    StartBang(pEnemy->x + Size, pEnemy->y + Size, false);
    End(pEnemy);
    AddScore(Points[pEnemy->type]);
}


bool HitBulletGroundEnemy(byte x, byte y)
{
    constexpr byte BulletSize = CoordRate;
    constexpr byte EnemySize = CoordRate * 2;
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->y >= RangeY) continue;
        if (
            pEnemy->y < y + BulletSize &&
            y < pEnemy->y + EnemySize
        ) {
            byte bulletLeft;
            bulletLeft = x + BulletSize;
            if (
                pEnemy->x < bulletLeft + 1 &&
                bulletLeft < pEnemy->x + (EnemySize + 1)
            ) {
                Destroy(pEnemy);
                return true;
            }
        }
    }
    return false;
}
