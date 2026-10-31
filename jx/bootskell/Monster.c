#include "Movable.h"
#include "Monster.h"
#include "Sprite.h"
#include "Stage.h"
#include "Block.h"
#include "Math.h"
#include "Man.h"
#include "Main.h"
#include "Chars.h"

constexpr byte Count = Sprite_Block - Sprite_Monster;
constexpr byte IntervalShift = MapShift * 2;
constexpr byte IntervalMask = MapRate * 2 - 1;

byte MonsterCount;
Monster[Count] Monsters;

void InitMonsters()
{
    ptr<Monster> pMonster;
    byte count, i, sprite;

    pMonster = Monsters;
    count = pStage->enemyCount;
    i = 0;
    sprite = Sprite_Monster;
    while (i < count) {
        pMonster->_.status = Movable_Live;
        pMonster->_.sprite = sprite;
        ++sprite;
        ++i;
        ++pMonster;
    }
    while (i < Count) {
        pMonster->_.status = 0;
        pMonster->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++i;
        ++pMonster;
    }
}


static void Show(ptr<Monster> pMonster)
{
    byte pattern;
    if ((pMonster->_.status & Movable_Pushing) != 0) {
        pattern = ((pMonster->_.status & Movable_PatternMask) >> 1) + Pattern_Monster + 8;
    }
    else {
        pattern = ((pMonster->_.status & Movable_PatternMask)) + Pattern_Monster;
    }
    ShowSprite(&pMonster->_, pattern);
}


static void DecideTarget(ptr<Monster> pMonster)
{
    if (pMonster->_.x == Man.x || pMonster->_.y == Man.y) {
        man:
        pMonster->targetX = Man.x;
        pMonster->targetY = Man.y;
        return;
    }
    {
        ptr<sbyte> pElements;
        byte thisX, thisY, manX, manY, minX, minY, minDistance;
        thisX = pMonster->_.x >> MapShift;
        thisY = pMonster->_.x >> MapShift;
        manX = Man.x >> MapShift;
        manY = Man.y >> MapShift;
        minDistance = 0xff;
        pElements = DirectionElements;
        repeat(4) {
            sbyte dx, dy;
            byte x, y;
            byte cell;
            dx = *pElements;
            ++pElements;
            dy = *pElements;
            ++pElements;
            x = manX;
            y = manY;
            do {
                x += dx;
                y += dy;
                cell = GetCell(x, y);
            } while (cell == Cell_None);
            if (cell < Cell_Wall) {
                byte distance;
                x += dx;
                y += dy;
                cell = GetCell(x, y);
                if (cell >= Cell_Wall) goto nextDirection;
                distance = Abs(manX, thisX) + Abs(manY, thisY);
                if (distance < minDistance) {
                    minDistance = distance;
                    minX = x;
                    minY = y;
                }
            }
            nextDirection:
            ;
        }
        if (minDistance == 0xff) goto man;
        pMonster->targetX = minX << MapShift;
        pMonster->targetY = minY << MapShift;
    }
}


static void DecideDirection(ptr<Monster> pMonster)
{
    byte[4] directions;
    byte target;

    if (
        pMonster->targetX != pMonster->_.x ||
        pMonster->targetY != pMonster->_.y
    ) {    
        if (Abs(pMonster->targetX, pMonster->_.x) > Abs(pMonster->targetY, pMonster->_.y)) {
            byte verticalDirectionIndex;
            if (pMonster->targetX < pMonster->_.x) {
                if (pMonster->_.dx <= 0) {
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
                if (pMonster->_.dx >= 0) {
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
            if (pMonster->targetY < pMonster->_.y && pMonster->_.dy <= 0 || pMonster->_.dy < 0) {
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
            if (pMonster->targetY < pMonster->_.y) {
                if (pMonster->_.dy <= 0) {
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
                if (pMonster->_.dy >= 0) {
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
            if (pMonster->targetX < pMonster->_.y && pMonster->_.dx <= 0 || pMonster->_.dx < 0) {
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
                byte direction, newX, newY, cell;
                byte count;
                direction = *pDirection;
                cell = NextCellOrMovable(&pMonster->_, direction);
                if (cell < Cell_Wall) {
                    SetDirection(&pMonster->_, direction);
                    return;
                }
            }
        }
    }
    pMonster->_.dx = 0;
    pMonster->_.dy = 0;
}


void StartMonsters()
{
    ptr<byte> p;
    ptr<Monster> pMonster;
    MonsterCount = 0;
    p = pStage->pEnemies;
    for (pMonster : Monsters) {
        if ((pMonster->_.status & Movable_Live) != 0) {
            pMonster->_.status = Movable_Live;
            pMonster->_.clock = 0;
            LocateMovableB(&pMonster->_, *p);
            DecideTarget(pMonster);
            DecideDirection(pMonster);
            Show(pMonster);
            ++MonsterCount;
        }
        ++p;
    }
}


void MoveMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->_.status & Movable_Live) == 0) continue;
        if ((pMonster->_.status & Movable_Pushing) != 0) {
            ++pMonster->_.clock;
            if (pMonster->_.clock >= CoordRate) {
                pMonster->_.status &= ~Movable_Pushing;
            }
            continue;
        }
        if ((pMonster->_.clock & IntervalMask) == 0 && (
                ((pMonster->_.clock >> IntervalShift) & 0x0f) <= CurrentStage || 
                (
                    pMonster->targetX == pMonster->_.x &&
                    pMonster->targetY == pMonster->_.y
                )
        )) {
            DecideTarget(pMonster);
        }
        if (IsOnGrid(&pMonster->_)) {
            byte cell;
            if ((pMonster->_.clock & MapMask) == 0) {
                DecideDirection(pMonster);
            }
            cell = NextCellOrMovable(
                &pMonster->_, 
                pMonster->_.status & Movable_DirectionMask
            );
            if (cell != Cell_None) {
                if (cell == Cell_Block) {
                    if (PushBlock(&pMonster->_)) {
                        pMonster->_.clock = 0;
                    }
                }
                pMonster->_.dx = 0;
                pMonster->_.dy = 0;
            }
        }
        {
            byte seq;
            pMonster->_.x += pMonster->_.dx;
            pMonster->_.y += pMonster->_.dy;
            seq = ((pMonster->_.x + pMonster->_.y + CoordRate / 2) >> CoordShift) & 1;
            pMonster->_.status = (pMonster->_.status & ~Movable_SeqMask) | seq;
        }
        Show(pMonster);
        ++pMonster->_.clock;
    }
}


bool IsNearMonster(ptr<Movable> pMovable, byte x, byte y)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->_.status & Movable_Live) == 0) continue;
        if (pMovable != &pMonster->_) {
            byte thisX, thisY;
            thisX = pMonster->_.x >> MapShift;
            thisY = pMonster->_.y >> MapShift;
            if (x == thisX && y == thisY) return true;
            if (!IsOnGrid(&pMonster->_)) {
                thisX += pMonster->_.dx;
                thisY += pMonster->_.dy;
                if (x == thisX && y == thisY) return true;
            }
        }
    }
    return false;
}


bool HitMonster(ptr<Movable> pBlock)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->_.status & Movable_Live) == 0) continue;
        if (IsNear(pBlock, &pMonster->_)) {
            pMonster->_.status &= ~Movable_Live;
            HideSprite(pMonster->_.sprite);
            OnHitBlock(pBlock, &pMonster->_);
            --MonsterCount;
        }
    }
}
