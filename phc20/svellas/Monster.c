#include "Monster.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Stage.h"
#include "Math.h"
#include "Main.h"

extern void _deb();

constexpr byte Monster_Confuse = 0x10;
constexpr byte Monster_Throgh = 0x20;

static const Direction[] Directions = {
    { -1, 0 },
    { 1, 0 },
    { 0, -1 },
    { 0, 1 },
};

Monster[MaxMonsterCount] Monsters;

static void DecideDirection(ptr<Movable> pMonster)
{
    static byte[4] directionIndices;

    if (Abs(Man.x, pMonster->x) > Abs(Man.y, pMonster->y)) {
        byte verticalDirectionIndex;
        if (Man.x < pMonster->x) {
            if (pMonster->dx <= 0) {
                directionIndices[0] = Direction_Left;
                directionIndices[3] = Direction_Right;
                verticalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Right;
                directionIndices[3] = Direction_Left;
                verticalDirectionIndex = 0;
            }
        }
        else {
            if (pMonster->dx >= 0) {
                directionIndices[0] = Direction_Right;
                directionIndices[3] = Direction_Left;
                verticalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Left;
                directionIndices[3] = Direction_Right;
                verticalDirectionIndex = 0;
            }
        }
        if (Man.y < pMonster->y && pMonster->dy <= 0 || pMonster->dy < 0) {
            directionIndices[verticalDirectionIndex] = Direction_Up;
            ++verticalDirectionIndex;
            directionIndices[verticalDirectionIndex] = Direction_Down;
        }
        else {
            directionIndices[verticalDirectionIndex] = Direction_Down;
            ++verticalDirectionIndex;
            directionIndices[verticalDirectionIndex] = Direction_Up;
        }
    }
    else {
        byte horizontalDirectionIndex;
        if (Man.y < pMonster->y) {
            if (pMonster->dy <= 0) {
                directionIndices[0] = Direction_Up;
                directionIndices[3] = Direction_Down;
                horizontalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Down;
                directionIndices[3] = Direction_Up;
                horizontalDirectionIndex = 0;
            }
        }
        else {
            if (pMonster->dy >= 0) {
                directionIndices[0] = Direction_Down;
                directionIndices[3] = Direction_Up;
                horizontalDirectionIndex = 1;
            }
            else {
                directionIndices[2] = Direction_Up;
                directionIndices[3] = Direction_Down;
                horizontalDirectionIndex = 0;
            }
        }
        if (Man.x < pMonster->y && pMonster->dx <= 0 || pMonster->dx < 0) {
            directionIndices[horizontalDirectionIndex] = Direction_Left;
            ++horizontalDirectionIndex;
            directionIndices[horizontalDirectionIndex] = Direction_Right;
        }
        else {
            directionIndices[horizontalDirectionIndex] = Direction_Right;
            ++horizontalDirectionIndex;
            directionIndices[horizontalDirectionIndex] = Direction_Left;
        }
    }
    {
        bool throughable = (pMonster->status & Monster_Throgh) != 0;
        byte i = 0;
        byte column = pMonster->x >> (CoordShift + 2);
        byte row = pMonster->y >> (CoordShift + 2);
        ptr<byte> pMap = MapPtr(column, row);
        byte panel = *pMap;
        ptr<byte> pDirectionIndex;
        for (pDirectionIndex: directionIndices) {
            byte index = *pDirectionIndex;
            ptr<Direction> pDirection = Directions + index;
            bool can = false;
            sbyte dx = pDirection->dx;
            sbyte dy = pDirection->dy;
            if (dx < 0) {
                if (column == 0) goto judgementEnd;
                if ((panel & Panel_Left) != 0) goto judgementEnd;
                byte left = *(pMap - 1);
                can = left != 0 && (left & Panel_Right) == 0;
                goto judgementEnd;
            }
            if (dx > 0) {
                if (column == ColumnCount - 1) goto judgementEnd;
                if ((panel & Panel_Right) != 0) goto judgementEnd;
                byte right = *(pMap + 1);
                can = right != 0 && (right & Panel_Left) == 0;
                goto judgementEnd;
            }
            if (dy < 0) {
                if (row == 0) goto judgementEnd;
                if ((panel & Panel_Top) != 0) goto judgementEnd;
                byte upper = *(pMap - ColumnCount);
                can = upper != 0 && (upper & Panel_Bottom) == 0;
                goto judgementEnd;
            }
            if (dy > 0) {
                if (row == RowCount - 1) goto judgementEnd;
                if ((panel & Panel_Bottom) != 0) goto judgementEnd;
                byte lower = *(pMap + ColumnCount);
                can = lower != 0 && (lower & Panel_Top) == 0;
                // goto judgementEnd;
            }
            judgementEnd:
            if (can) {
                if (throughable && i == 0 && panel != 0) {
                    pMonster->status &= ~Monster_Throgh;
                }
            }
            else if (throughable) {
                byte nextColumn = column + dx;
                byte nextRow = row + dy;
                can = nextColumn < ColumnCount && nextRow < RowCount;
            }
            if (can) {
                pMonster->dx = dx;
                pMonster->dy = dy;
                byte pattern = index << 1;
                byte confuse = i >= 2 ? Monster_Confuse : 0;
                pMonster->status = (pMonster->status & ~Movable_PatternMask) | pattern | confuse;
                return;
            }
            ++i;
        }
    }
    pMonster->dx = 0;
    pMonster->dy = 0;
}


static void Show(ptr<Monster> pMonster)
{
    byte status = pMonster->status;
    byte pattern = (status & Movable_PatternMask);
    if ((status & Monster_Throgh) != 0) {
        pattern = Char_MonserRev + (pattern << 1);
    }
    else {
        byte seq = ((pMonster->x + pMonster->y) >> CoordShift) & 1;
        pattern = Char_Monster + ((pattern + seq) << 2);
    }
    ShowSprite(pMonster, pattern);
}

void InitMonsters()
{
    ptr<byte> pSource = pStage->pMonsters;
    ptr<Monster> pMonster = Monsters;
    byte count = pStage->monsterCount;
    byte i = 0;
    byte sprite = Sprite_Monster;
    while (i < count) {
        pMonster->status = Movable_Live;
        pMonster->sprite = sprite;
        pMonster->dx = 0;
        pMonster->dy = 0;
        LocateMovable(pMonster, *pSource); ++pSource;
        DecideDirection(pMonster);
        Show(pMonster);
        ++sprite;
        ++i;
        ++pMonster;
    }
    while (i < MaxMonsterCount) {
        pMonster->status = 0;
        pMonster->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++i;
        ++pMonster;
    }
}


void MoveMonsters()
{
    static byte clock;
    ++clock;

    ptr<Movable> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0) {
            byte x = pMonster->x;
            byte y = pMonster->y;
            if (((x | y) & CoordMask) == 0) {
                x >>= CoordShift;
                y >>= CoordShift;
                if ((x & 3) == 1 && (y & 3) == 1) {
                    if ((status & Monster_Confuse) != 0 && (Rnd() << 2) < CurrentStage) {
                        pMonster->status = status & ~Monster_Confuse | Monster_Throgh;
                    }
                    DecideDirection(pMonster);
                }
            }
            if ((clock & 1) == 0 || (pMonster->status & Monster_Throgh) == 0) {
                MoveMovable(pMonster);
            }
            if ((Man.status & Movable_OnPanel) == 0 && IsNear(pMonster, &Man)) {
                Man.status &= ~Movable_Live;
            }
            Show(pMonster);
        }
    }
}
