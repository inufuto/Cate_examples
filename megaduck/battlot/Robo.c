#include "Robo.h"
#include "Direction.h"
#include "Sprite.h"
#include "Stage.h"
#include "Fort.h"
#include "Bullet.h"

extern void _deb();

constexpr byte SizeInCoord = RoboSize * CoordRate;
constexpr byte HitRange = SizeInCoord - 1;

byte RoboStartIndex;

bool StartRobo(ptr<Robo> pRobo, byte fortX, byte fortY)
{
    static const byte[] StartOffsets = {
        -2, -1,
        -2, 1,
        0, 3,
        2, 3,
        4, 1,
        4, -1,
        2, -3,
        0, -3,
        -4, 0, 
        1, 5,
        6, 0,
        1, 4,
    };
    constexpr byte PositionCount = 12;
    ptr<byte> pOffset;
    pOffset = StartOffsets + RoboStartIndex;
    repeat (PositionCount) {
        byte x, y;
        x = fortX + *pOffset;
        ++pOffset;
        y = fortY + *pOffset;
        ++pOffset;
        RoboStartIndex += 2;
        if (RoboStartIndex >= PositionCount * 2) {
            pOffset = StartOffsets;
            RoboStartIndex = 0;
        }
        if (WallAroundRobo(pRobo, x, y) == 0) {
            pRobo->x = x << CoordShift;
            pRobo->y = y << CoordShift;
            return true;
        }
    }
    return false;
}


byte WallAroundRobo(ptr<Robo> pRobo, byte x, byte y)
{
    byte maxWall;
    byte xCoord, yCoord;
    if (
        x >= StageWidth ||
        x + (RoboSize - 1) >= StageWidth || 
        y >= StageHeight ||
        y + (RoboSize - 1) >= StageHeight
    ) {
        return Wall_Hard;
    }
    if (HitMyFortR(x, y)) {
        return Wall_MyFort;
    }
    if (HitEnemyFortR(x, y)) {
        return Wall_EnemyFort;
    }
    xCoord = x << CoordShift;
    yCoord = y << CoordShift;
    if (HitMyRoboR(pRobo, xCoord, yCoord)) {
        return Wall_MyRobo;
    }
    if (HitEnemyRoboR(pRobo, xCoord, yCoord)) {
        return Wall_EnemyRobo;
    }

    maxWall = 0;
    repeat (RoboSize) {
        repeat (RoboSize) {
            byte wall;
            wall = GetWall(x, y);
            if (wall > maxWall) {
                maxWall = wall;
            }
            if (wall >= Wall_Hard) return wall;
            ++x;
        }
        x -= RoboSize;
        ++y;
    }
    return maxWall;
}


byte TestMoveRobo(ptr<Robo> pRobo, byte direction)
{
    byte x, y, maxWall;

    ptr<sbyte> pDirection;
    pDirection = DirectionPtr(direction);
    x = pRobo->x >> CoordShift;
    x += *pDirection;
    ++pDirection;
    y = pRobo->y >> CoordShift;
    y += *pDirection;

    maxWall = WallAroundRobo(pRobo, x, y);
    if (maxWall == 0) {
        pRobo->status |= Robo_CanMove_Mask;
    }
    else {
        pRobo->status &= ~Robo_CanMove_Mask;
    }
    return maxWall;
}


void SetRoboDirection(ptr<Robo> pRobo, byte direction)
{
    ptr<sbyte> pDirection;
    pRobo->status = pRobo->status & ~Robo_Direction_Mask | direction;
    pDirection = DirectionPtr(direction);
    pRobo->dx = *pDirection;
    ++pDirection;
    pRobo->dy = *pDirection;
}


void MoveRobo(ptr<Robo> pRobo)
{
    byte seq;

    if ((pRobo->status & Robo_CanMove_Mask) == 0) return;

    pRobo->x += pRobo->dx;
    pRobo->y += pRobo->dy;
    
    seq = ((pRobo->x + pRobo->y + CoordRate / 2) >> CoordShift) & 1;
    pRobo->status = (pRobo->status & ~Robo_Seq_Mask) | seq;
}

void Fire(ptr<Robo> pRobo, bool my)
{
                                        _deb();
    static const sbyte[] BulletOffsets = {
        2 * CoordRate, 0 * CoordRate,
        -1 * CoordRate, 0 * CoordRate,
        0 * CoordRate, 2 * CoordRate,
        0 * CoordRate, -1 * CoordRate,
    };
    byte direction, x, y, next;
    ptr<sbyte> pOffset;
    sbyte xOffset;
    direction = pRobo->status & Robo_Direction_Mask;
    pOffset = BulletOffsets + direction;
    xOffset = *pOffset;
    x = pRobo->x + xOffset;
    if (
        (xOffset > 0 && x < pRobo->x) ||
        (xOffset < 0 && x > pRobo->x)
    ) {
        return;
    }
    ++pOffset;
    y = pRobo->y + *pOffset;
    if (my) {
        StartMyBullet(x, y, direction);
    }
    else {
        StartEnemyBullet(x, y, direction);
    }
}


bool HitRoboR(ptr<Robo> pRobo, byte x, byte y)
{
    if ((pRobo->status & Robo_Status_Mask) == Robo_Status_None) return false;
    return
        pRobo->x + HitRange >= x && x + HitRange >= pRobo->x &&
        pRobo->y + HitRange >= y && y + HitRange >= pRobo->y;
}

bool HitRoboB(ptr<Robo> pRobo, ptr<Bullet> pBullet)
{
    // byte right;
    if ((pRobo->status & Robo_Status_Mask) == Robo_Status_None) return false;
    return
        pBullet->x + pBullet->width >= pRobo->x && 
        pRobo->x + HitRange >= pBullet->x &&
        pBullet->y + pBullet->height >= pRobo->y && 
        pRobo->y + HitRange >= pBullet->y;
    // right = pRobo->x + width;
    // return
    //     x >= pRobo->x && (right < pRobo->x || x < right) &&
    //     y >= pRobo->y && y < pRobo->y + height;
}