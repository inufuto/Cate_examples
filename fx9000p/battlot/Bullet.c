#include "Bullet.h"
#include "Sprite.h"
#include "Stage.h"
#include "Direction.h"
#include "Stage.h"
#include "Robo.h"
#include "Fort.h"
#include "Chars.h"

constexpr byte Size = 1;
constexpr byte StepShift = 0;

Bullet[Sprite_EnemyBullet - Sprite_MyBullet] MyBullets;
Bullet[Sprite_Bang - Sprite_EnemyBullet] EnemyBullets;

static void Draw(ptr<Bullet> pBullet)
{
    if ((pBullet->status & Bullet_Live_Mask) != 0) {
        ShowSprite(pBullet->sprite, pBullet->x, pBullet->y, 
            Char_Bullet + (pBullet->status & Bullet_Pattern_Mask));
    }
    else {
        HideSprite(pBullet->sprite);
    }
}


void IntBullets()
{
    ptr<Bullet> pBullet;
    for (pBullet: MyBullets) {
        pBullet->status = 0;
    }
    for (pBullet: EnemyBullets) {
        pBullet->status = 0;
    }
}

extern bool Hit(ptr<Bullet> pBullet);

static void Start(ptr<Bullet> pBullet, byte x, byte y, byte sprite, byte direction, byte side)
{
    static const byte[] Sizes = {
        0, 1,
        0, 1,
        1, 0,
        1, 0,
    };

    ptr<sbyte> pDirection;
    ptr<byte> pSize;
    byte pattern;
    
    pBullet->x = x;
    pBullet->y = y;
    
    pDirection = DirectionPtr(direction);
    pBullet->dx = *pDirection << StepShift;
    ++pDirection;
    pBullet->dy = *pDirection << StepShift;

    pSize = Sizes + direction;
    pBullet->width = *pSize;
    ++pSize;
    pBullet->height = *pSize;

    pBullet->step = 0;
    pBullet->sprite = sprite;
    pattern = (direction & 4) != 0 ? 1 : 0;
    pBullet->status = direction | pattern | Bullet_Live_Mask | side;
    // Hit(pBullet);
    Draw(pBullet);
}

bool StartMyBullet(byte x, byte y, byte direction)
{
    byte sprite;
    ptr<Bullet> pBullet;

    sprite = Sprite_MyBullet;
    for (pBullet: MyBullets) {
        if ((pBullet->status & Bullet_Live_Mask) == 0) {
            Start(pBullet, x, y, sprite, direction, 0);
            return true;
        }
        ++sprite;
    }
    return false;
}


bool StartEnemyBullet(byte x, byte y, byte direction)
{
    byte sprite;
    ptr<Bullet> pBullet;

    sprite = Sprite_EnemyBullet;
    for (pBullet: EnemyBullets) {
        if ((pBullet->status & Bullet_Live_Mask) == 0) {
            Start(pBullet, x, y, sprite, direction, Bullet_Side_Mask);
            return true;
        }
        ++sprite;
    }
    return false;
}

static bool HitWall(byte x, byte y)
{
    byte wall;
    wall = GetWall(x, y);
    if (wall == 0) return false;
    if (wall < Wall_Hard) {
        --wall;
        SetWall(x, y, wall);
    }
    return true;
}

static bool HitB(ptr<Bullet> pBullet, ptr<Bullet> p)
{
    if ((pBullet->status & Bullet_Live_Mask) == 0) return false;
    if (
        p->x + p->width >= pBullet->x && 
        pBullet->x + pBullet->width >= p->x &&
        p->y + p->height >= pBullet->y && 
        pBullet->y + pBullet->height >= p->y
    ) {
        pBullet->status &= ~Bullet_Live_Mask;
        Draw(pBullet);
        return true;
    }
    return false;
}

static bool HitAnyBullet(ptr<Bullet> p)
{
    ptr<Bullet> pBullet;
    for (pBullet : MyBullets) {
        if (pBullet != p && HitB(pBullet, p)) {
            return true;
        }
    }
    for (pBullet : EnemyBullets) {
        if (pBullet != p && HitB(pBullet, p)) {
            return true;
        }
    }
    return false;
}

static bool Hit(ptr<Bullet> pBullet)
{
    byte x, y, width, height, side;
    if ((pBullet->step & StepMask) != 0) return false;

    x = pBullet->x;
    y = pBullet->y;
    width = pBullet->width;
    height = pBullet->height;
    side = pBullet->status & Bullet_Side_Mask;
    {
        byte addedX, addedY;
        bool hit;
        hit = false;
        if (HitWall(x, y)) {
            hit = true;
        }
        addedX = x + width;
        addedY = y + height;
        if (HitWall(addedX, addedY)) {
            hit = true;
        }
        if (hit) goto hit;
    }
    {
        if (
            HitMyRoboB(pBullet) || HitEnemyRoboB(pBullet) || 
            HitAnyBullet(pBullet)
        ) {
            goto hit;
        }
    }
    {
        if (
            HitMyFortB(x, y, width, height, side) || 
            HitEnemyFortB(x, y, width, height, side)
        ) {
            goto hit;
        }
    }
    return false;

    hit:
    pBullet->status &= ~Bullet_Live_Mask;
    return true;
}


static void Move(ptr<Bullet> pBullet, bool my)
{
    if ((pBullet->step & StepMask) == 0) {
        if (!Hit(pBullet)) {
            pBullet->x += pBullet->dx;
            pBullet->y += pBullet->dy;
            if (pBullet->x >= StageWidth || pBullet->y >= StageHeight) {
                pBullet->status &= ~Bullet_Live_Mask;
            }
            else {
                Hit(pBullet);
            }
        }
        Draw(pBullet);
    }
    ++pBullet->step;
}

void MoveMyBullets()
{
    ptr<Bullet> pBullet;
    for (pBullet: MyBullets) {
        if ((pBullet->status & Bullet_Live_Mask) != 0) {
            Move(pBullet, true);
        }
    }
}


void MoveEnemyBullets()
{
    ptr<Bullet> pBullet;
    for (pBullet: EnemyBullets) {
        if ((pBullet->status & Bullet_Live_Mask) != 0) {
            Move(pBullet, false);
        }
    }
}
