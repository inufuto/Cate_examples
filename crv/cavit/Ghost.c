#include "Ghost.h"
#include "Sprite.h"
#include "Stage.h"
#include "Man.h"
#include "Direction.h"
#include "Main.h"
#include "Chars.h"

constexpr byte Color1 = 13;
constexpr byte Color2 = 1;
constexpr byte MaxCount = Sprite_Chaser - Sprite_Ghost;
Movable[MaxCount] Ghosts;
static ptr<byte> pGhostPositions;

static const byte[] Numbers = { 11, 8, 9, 4, 4, 12, 0, 12, 13, 11, 0, 6, 13, 12, 5, 15, };
static byte RndIndex;
static bool throughable;

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


ptr<byte> InitGhosts(ptr<byte> pStage)
{
    RndIndex = 0;
    pGhostPositions = pStage;
    return InitMonsters(Ghosts, MaxCount, Sprite_Ghost, pStage);
}

static void Draw(ptr<Movable> pGhost)
{
    byte status, c, xy, color;
    status = pGhost->status;
    c = Pattern_Ghost + ((status & Movable_Direction_Mask) << 2);
    xy = pGhost->x + pGhost->y;
    c += (xy >> (CoordShift - 2)) & 4;
    if ((status & Ghost_Status_Throgh) != 0) {
        if ((xy & 1) == 0) {
            color = Color1;
        }
        else {
            color = Color2;
        }
    }
    else {
        color = Color1;
    }
    ShowSprite(pGhost, c, color);
}


static byte Abs(byte a, byte b)
{
    if (a < b) {
        return b - a;
    }
    else {
        return a - b;
    }
}


static bool CanMove(ptr<Movable> pGhost, byte direction)
{
    byte mapX, mapY;
    byte current, next, nextT;
    SetDirection(pGhost, direction);
    mapX = pGhost->x >> MapShift;
    mapY = pGhost->y >> MapShift;
    current = CurrentTerrain(mapX, mapY);
    mapX += pGhost->dx;
    mapY += pGhost->dy;
    if (mapX >= MapWidth || mapY >= MapHeight) return false;
    next = CurrentTerrain(mapX, mapY);
    nextT = next & Terrain_Mask;
    if ((current & Terrain_Mask) == 0) {
        byte i;
        i = direction >> 1;
        pGhost->status &= ~Ghost_Status_Throgh;
        if (
            nextT == Terrain_Space &&
            (current & WallBits[i]) == 0 &&
            (next & WallBits[i ^ 1]) == 0
        ) goto can;
        if (!throughable) return false;
    }
    pGhost->status |= Ghost_Status_Throgh;
    if (nextT >= Terrain_Wall) return false;
    can:
    return !AdjacentOther(pGhost);
}

static byte  DecideDirection(ptr<Movable> pGhost)
{
    byte[4] directions;
    byte target;
    
    if (Abs(man.x, pGhost->x) > Abs(man.y, pGhost->y)) {
        byte verticalDirectionIndex;
        if (man.x < pGhost->x) {
            if (pGhost->dx <= 0) {
                directions[0] = Direction_Left;
                directions[3] = Direction_Right;
                verticalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Right;
                directions[3] = Direction_Left;
                verticalDirectionIndex = 0;
            }
        }
        else {
            if (pGhost->dx >= 0) {
                directions[0] = Direction_Right;
                directions[3] = Direction_Left;
                verticalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Left;
                directions[3] = Direction_Right;
                verticalDirectionIndex = 0;
            }
        }
        if (man.y < pGhost->y && pGhost->dy <= 0 || pGhost->dy < 0) {
            directions[verticalDirectionIndex] = Direction_Up;
            ++verticalDirectionIndex;
            directions[verticalDirectionIndex] = Direction_Down;
        }
        else {
            directions[verticalDirectionIndex] = Direction_Down;
            ++verticalDirectionIndex;
            directions[verticalDirectionIndex] = Direction_Up;
        }
    }
    else {
        byte horizontalDirectionIndex;
        if (man.y < pGhost->y) {
            if (pGhost->dy <= 0) {
                directions[0] = Direction_Up;
                directions[3] = Direction_Down;
                horizontalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Down;
                directions[3] = Direction_Up;
                horizontalDirectionIndex = 0;
            }
        }
        else {
            if (pGhost->dy >= 0) {
                directions[0] = Direction_Down;
                directions[3] = Direction_Up;
                horizontalDirectionIndex = 1;
            }
            else {
                directions[2] = Direction_Up;
                directions[3] = Direction_Down;
                horizontalDirectionIndex = 0;
            }
        }
        if (man.x < pGhost->y && pGhost->dx <= 0 || pGhost->dx < 0) {
            directions[horizontalDirectionIndex] = Direction_Left;
            ++horizontalDirectionIndex;
            directions[horizontalDirectionIndex] = Direction_Right;
        }
        else {
            directions[horizontalDirectionIndex] = Direction_Right;
            ++horizontalDirectionIndex;
            directions[horizontalDirectionIndex] = Direction_Left;
        }
    }
    {
        bool throughable;
        ptr<byte> pDirection;
        for (pDirection: directions) {
            byte newDirection, newX, newY, wall;
            ptr<sbyte> pNewDirection;
            byte count;
            newDirection = *pDirection;
            if (CanMove(pGhost, newDirection)) {
                pGhost->status |= Movable_Status_CanMove;
                return;
            }
        }
    }
    pGhost->status &= ~Movable_Status_CanMove;
}


void StartGhosts()
{
    StartMonsters(Ghosts, MaxCount, pGhostPositions);
    {
        ptr<Movable> pGhost;
        for (pGhost: Ghosts) {
            if ((pGhost->status & Movable_Status_Live) == 0) continue;
            DecideDirection(pGhost);
            Draw(pGhost);
        }
    }
}

void MoveGhosts()
{
    ptr<Movable> pGhost;
    for (pGhost: Ghosts) {
        byte status;
        if ((pGhost->status & Movable_Status_Live) == 0) continue;
        CatchMan(pGhost);
        if (
            (pGhost->dx | pGhost->dy) == 0 ||
            CanChangeDirection(pGhost)
        ) {
            throughable = 
                 ((man.x | man.y) & MapMask) == 0 && 
                 Rnd() <= CurrentStage;
            DecideDirection(pGhost);
        }
        status = pGhost->status;
        if ((status & Ghost_Status_Throgh) != 0) {
            if ((status & Ghost_Status_Wait) != 0) {
                pGhost->status &= ~Ghost_Status_Wait;
                continue;
            }
            pGhost->status |= Ghost_Status_Wait;
        }
        if (AdjacentOther(pGhost)) {
            // pGhost->dx = -pGhost->dx;
            // pGhost->dy = -pGhost->dy;
            pGhost->dx = 0;
            pGhost->dy = 0;
            continue;
        }
        if (MoveMovable(pGhost)) {
            Draw(pGhost);
            CatchMan(pGhost);
        }
    }
}


void HitGhost(ptr<Movable> pMovable)
{
    HitMonsterInArray(Ghosts, MaxCount, pMovable);
}


bool AdjacentGhost(ptr<Movable> pMovable, byte x, byte y)
{
    return AdjacentOtherInArray(Ghosts, MaxCount, pMovable, x, y);
}