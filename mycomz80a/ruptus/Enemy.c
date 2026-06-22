#include "Enemy.h"
#include "Stage.h"
#include "Fighter.h"
#include "VVram.h"
#include "Sprite.h"
#include "Chars.h"
#include "Direction.h"
#include "Main.h"
#include "Bang.h"
#include "Barrier.h"
#include "Fort.h"
#include "Mover.h"
#include "Item.h"
#include "Sound.h"
#include "Vram.h"

extern bool StartEnemyBullet(ptr<Enemy> pEnemy);

constexpr byte MaxCount = 3;
constexpr byte HalfSize = 1;
constexpr byte SpriteColor = 9;
constexpr byte HiVelocity = 50;
constexpr byte LoVelocity = HiVelocity * 70 / 100;

constexpr byte InvalidSprite = 0x80;

Enemy[MaxCount] Enemies;

static const byte[] Numbers = { 11, 8, 9, 4, 4, 12, 0, 12, 13, 11, 0, 6, 13, 12, 5, 15, };
static byte RndIndex;

void InitEnemies()
{
    ptr<Enemy> pEnemy;
    for (pEnemy: Enemies) {
        pEnemy->sprite = InvalidSprite;
    }
    RndIndex = 0;
}

byte Rnd() 
{
    byte r;
    r = Numbers[RndIndex];
    ++RndIndex;
    if (RndIndex >= 16) {
        RndIndex = 0;
    }
    return r;
}


static void Locate(ptr<Enemy> pEnemy)
{
    byte x, y;
    x = OffsetX(pEnemy->x);
    if (x + VVramWidth / 4 >= VVramWidth + VVramWidth / 2) goto end;
    y = OffsetY(pEnemy->y);
    if (y + VVramWidth / 4 >= VVramHeight + VVramWidth / 2) goto end;
    x -= HalfSize;
    y -= HalfSize;
    if (x < VVramWidth - HalfSize * 2 && y < VVramHeight - HalfSize * 2) {
        ShowSprite(pEnemy->sprite, x, y, Char_Enemy + (pEnemy->direction << 2));
    }
    else {
        HideSprite(pEnemy->sprite);
    }
    return;
end:
    HideSprite(pEnemy->sprite);
    pEnemy->sprite = InvalidSprite;
}

void StartEnemy()
{
    ptr<Enemy> pEnemy;
    byte sprite;
    if ((Clock & 0x03f) != 0) return;
    if ((Rnd() << 2) >= CurrentStage + 1) return;

    sprite = Sprite_Enemy;
    for (pEnemy : Enemies) {
        byte x, y, direction, rnd;
        if (pEnemy->sprite != InvalidSprite) goto next;

        rnd = ((sbyte)Rnd() - 8) >> 1;
        if (FighterDy < 0) {
            x = AddX(FighterX, rnd);
            y = BaseY;
            direction = Direction_Down;
        }
        else if (FighterDy > 0) {
            x = AddX(FighterX, rnd);
            y = AddY(BaseY, VVramHeight);
            direction = Direction_Up;
        }
        else if (FighterDx < 0) {
            x = BaseX;
            y = AddY(FighterY, rnd);
            direction = Direction_Right;
        }
        else {
            x = AddX(BaseX, VVramWidth);
            y = AddY(FighterY, rnd);
            direction = Direction_Left;
        }
        if (NearFort(x, y, 5 / 2) != nullptr || NearBarrier(x, y, 5 / 2)) return;

        pEnemy->x = x;
        pEnemy->y = y;
        pEnemy->direction = direction;
        pEnemy->sprite = sprite;
        pEnemy->numerator = HiVelocity;
        pEnemy->denominator = 0;
        pEnemy->bullttCount = 0;
        Locate(pEnemy);
        break;
    next:
        ++sprite;
    }
}

static void Destroy(ptr<Enemy> pEnemy)
{
    Sound_SmallBang();
    StartBang(pEnemy->x, pEnemy->y, false);
    // Sound_Hit();
    HideSprite(pEnemy->sprite);
    pEnemy->sprite = InvalidSprite;
    AddScore(10);
    if ((Rnd() & 7) == 0) {
        StartItem(pEnemy->x, pEnemy->y);
    }
}

static bool Hit(ptr<Enemy> pEnemy)
{
    if (HitFighter(pEnemy->x, pEnemy->y, 0)) {
        end:
        Destroy(pEnemy);
        return true;
    }
    // if (HitBarrier(pEnemy->x, pEnemy->y, Size)) {
    //     goto end;
    // }
    // if (HitFort(pEnemy->x, pEnemy->y, Size)) {
    //     goto end;
    // }
    return false;
}


void MoveEnemy()
{
    ptr<Enemy> pEnemy;
    for (pEnemy : Enemies) {
        sbyte dx, dy;
        byte direction;
        bool attaking;

        if (pEnemy->sprite == InvalidSprite) continue;
        if ((Clock & 7) == 0) {
            ptr<Direction> pDirection;
            pEnemy->denominator -= pEnemy->numerator;
            if (pEnemy->denominator >= 0) goto locate;
            if (Hit(pEnemy)) {
                continue;
            }
            pDirection = Directions + pEnemy->direction;
            pEnemy->x = AddX(pEnemy->x, pDirection->dx);
            pEnemy->y = AddY(pEnemy->y, pDirection->dy);
            pEnemy->denominator += 100;
        }
        attaking = pEnemy->bullttCount <= CurrentStage;

        if ((Clock & 1) == 0) {
            dx = SubX(FighterX, pEnemy->x); 
            dy = SubY(FighterY, pEnemy->y);
            if (!attaking) {
                dx = -dx; 
                dy = -dy;
            }
            if (dx < 0) {
                if (dy < 0) {
                    direction = Direction_UpLeft;
                }
                else if (dy == 0) {
                    direction = Direction_Left;
                }
                else {
                    direction = Direction_DownLeft;
                }
            }
            else if (dx == 0) {
                if (dy < 0) {
                    direction = Direction_Up;
                }
                else {
                    direction = Direction_Down;
                }
            }
            else {
                if (dy < 0) {
                    direction = Direction_UpRight;
                }
                else if (dy == 0) {
                    direction = Direction_Right;
                }
                else {
                    direction = Direction_DownRight;
                }
            }
        }
        pEnemy->direction = NewDirection(pEnemy->direction, direction);
        pEnemy->numerator = (direction & 1) == 0 ? HiVelocity : LoVelocity;
        
        if (attaking && (Rnd() << 1) <= CurrentStage)  {
            if (StartEnemyBullet(pEnemy)) {
                ++pEnemy->bullttCount;
            }
        }
        if (Hit(pEnemy)) {
            continue;
        }
    locate:
        Locate(pEnemy);
    }
}


bool HitEnemy(byte x, byte y, byte size)
{
    ptr<Enemy> pEnemy;
    for (pEnemy : Enemies) {
        byte xDiff, yDiff;
        if (pEnemy->sprite == InvalidSprite) continue;

        if (HitMover(pEnemy->x, pEnemy->y, HalfSize, x, y, size)) {
            Destroy(pEnemy);
            return true;    
        }
    }
    return false;
}
