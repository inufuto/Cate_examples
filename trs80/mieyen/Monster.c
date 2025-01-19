#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Math.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"
#include "Man.h"

extern void _deb();

// constexpr byte SpriteColor = 13;
constexpr byte Monster_Visible = 0x40;

Monster[MaxMonsterCount] Monsters;
byte MonsterCount;


void InitMonsters()
{
    ptr<Monster> pMonster = Monsters;
    byte count = pStage->enemyCount;
    byte i = 0;
    byte sprite = Sprite_Monster;
    while (i < count) {
        pMonster->status = Movable_Live | Monster_Visible;
        pMonster->sprite = sprite;
        ++sprite;
        ++pMonster;
        ++i;
    }
    while (i < MaxMonsterCount) {
        pMonster->status = 0;
        pMonster->sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++pMonster;
        ++i;
    }
}


void UpdateMonsterTargets()
{
    if (FoodCount == 0) return;
    ptr<byte> pCell = CellMap;
    byte cell = *pCell;
    byte column = 0;
    byte row = 0;
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0 && (status & Movable_Loose) == 0) {
            bool done = false;
            do {
                if ((cell & Cell_Food) != 0) {
                    pMonster->targetX = ToCoord(column) << CoordShift;
                    pMonster->targetY = ToCoord(row) << CoordShift;
                    done = true;
                }
                ++column;
                if (column >= ColumnCount) {
                    column = 0;
                    ++pCell;
                    ++row;
                    if (row >= RowCount) {
                        row = 0;
                        pCell = CellMap;
                    }
                    cell = *pCell;
                }
                else if ((column & 1) == 0) {
                    ++pCell;
                    cell = *pCell;
                }
                else {
                    cell >>= 4;
                }
            } while (!done);
        }
    }
}


static void Show(ptr<Monster> pMonster)
{
    static const byte[] Chars = {
        0x76, 0x4f, 0xb2, 0x4f, 0xf8, 0x9b, 0xf8, 0x17,
	    0xf8, 0xdf, 0xb0, 0x1f, 0x78, 0xd7, 0xb0, 0x1f,
    };
    if ((pMonster->status & Monster_Visible) != 0) {
        ShowMovable(pMonster, Chars);
    }
    else {
        // ShowMovable(pMonster, Chars);
        HideSprite(pMonster->sprite);
    }
}

static void DecideDirection(ptr<Monster> pMonster)
{
    static ptr<Direction>[4] directionPtrs;

    if (Abs(pMonster->targetX, pMonster->x) > Abs(pMonster->targetY, pMonster->y)) {
        ptr<ptr<Direction> > p1, p2;
        if (pMonster->targetX < pMonster->x) {
            sbyte dx = pMonster->dx;
            if (dx == 0) {
                directionPtrs[0] = Directions + Direction_Left;
                p1 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Right;
                p2 = directionPtrs + 3;
            }
            else if (dx < 0) {
                directionPtrs[0] = Directions + Direction_Left;
                p1 = directionPtrs + 1;
                p2 = directionPtrs + 2;
                directionPtrs[3] = Directions + Direction_Right;
            }
            else {
                p1 = directionPtrs + 0;
                p2 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Right;
                directionPtrs[3] = Directions + Direction_Left;
            }
        }
        else {
            sbyte dx = pMonster->dx;
            if (dx == 0) {
                directionPtrs[0] = Directions + Direction_Right;
                p1 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Left;
                p2 = directionPtrs + 3;
            }
            else if (dx < 0) {
                p1 = directionPtrs + 0;
                p2 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Left;
                directionPtrs[3] = Directions + Direction_Right;
            }
            else {
                directionPtrs[0] = Directions + Direction_Right;
                p1 = directionPtrs + 1;
                p2 = directionPtrs + 2;
                directionPtrs[3] = Directions + Direction_Left;
            }
        }
        if (pMonster->targetY <= pMonster->y && pMonster->dy <= 0) {
            *p1 = Directions + Direction_Up;
            *p2 = Directions + Direction_Down;
        }
        else {
            *p1 = Directions + Direction_Down;
            *p2 = Directions + Direction_Up;
        }
    }
    else {
        ptr<ptr<Direction> > p1, p2;
        if (pMonster->targetY < pMonster->y) {
            sbyte dy = pMonster->dy;
            if (dy == 0) {
                directionPtrs[0] = Directions + Direction_Up;
                p1 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Down;
                p2 = directionPtrs + 3;
            }
            else if (dy < 0) {
                directionPtrs[0] = Directions + Direction_Up;
                p1 = directionPtrs + 1;
                p2 = directionPtrs + 2;
                directionPtrs[3] = Directions + Direction_Down;
            }
            else {
                p1 = directionPtrs + 0;
                p2 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Down;
                directionPtrs[3] = Directions + Direction_Up;
            }
        }
        else {
            sbyte dy = pMonster->dy;
            if (dy == 0) {
                directionPtrs[0] = Directions + Direction_Down;
                p1 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Up;
                p2 = directionPtrs + 3;
            }
            else if (dy < 0) {
                p1 = directionPtrs + 0;
                p2 = directionPtrs + 1;
                directionPtrs[2] = Directions + Direction_Up;
                directionPtrs[3] = Directions + Direction_Down;
            }
            else {
                directionPtrs[0] = Directions + Direction_Down;
                p1 = directionPtrs + 1;
                p2 = directionPtrs + 2;
                directionPtrs[3] = Directions + Direction_Up;
            }
        }
        if (pMonster->targetX <= pMonster->y && pMonster->dx <= 0) {
            *p1 = Directions + Direction_Left;
            *p2 = Directions + Direction_Right;
        }
        else {
            *p1 = Directions + Direction_Right;
            *p2 = Directions + Direction_Left;
        }
    }
    {
        byte i = 0;
        ptr<ptr<Direction> > pp;
        for (pp: directionPtrs) {
            ptr<Direction> pDirection = *pp;
            sbyte dx = pDirection->dx;
            sbyte dy = pDirection->dy;
            if (CanMove(pMonster, pDirection->dx, pDirection->dy)) {
                SetDirection(pMonster, pDirection);
                return;
            }
            ++i;
        }
    }
    pMonster->dx = 0;
    pMonster->dy = 0;
}

void StartMonsters()
{
    UpdateMonsterTargets();
    MonsterCount = 0;
    ptr<byte> pByte = pStage->pEnemies;
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0) {
            pMonster->status = status | Monster_Visible;
            pMonster->dx = 0;
            pMonster->dy = 0;
            LocateMovable(pMonster, *pByte);
            DecideDirection(pMonster);
            Show(pMonster);
            ++MonsterCount;
        }
        ++pByte;
    }
}


void MoveMonsters()
{
    static byte clock;
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0) {
            if ((status & Movable_Loose) == 0) {
                MoveMovable(pMonster);
                if (IsOnGrid(pMonster)) {
                    pMonster->status &= ~Monster_Visible;
                    byte column = ToGrid(pMonster->x);
                    byte row = ToGrid(pMonster->y);
                    byte cell = GetCell(column, row);
                    if ((cell & Cell_Dot) != 0) {
                        SetCell(column, row, cell & ~Cell_Dot);
                    }
                    else if ((cell & Cell_Food) != 0) {
                        pMonster->status |= Monster_Visible;
                        SetCell(column, row, cell & ~Cell_Food);
                        --FoodCount;
                        PrintFoodCount();
                        Sound_Stole();
                        UpdateMonsterTargets();
                    }
                    DecideDirection(pMonster);
                }
                if ((Man.status & Movable_Loose) == 0 && IsNear(pMonster, &Man)) {
                    // FreezeMan();
                    Man.status &= ~Movable_Live;
                    pMonster->status |= Monster_Visible;
                }
            }
            else {
                if ((clock & CoordMask) == 0) {
                    status += 2;
                    if ((status & Movable_Pattern) == 0) {
                        pMonster->status = status & ~Movable_Live;
                        HideSprite(pMonster->sprite);
                        --MonsterCount;
                        goto next;
                    }
                    pMonster->status = status;
                }
            }
            Show(pMonster);
            next:;
        }
    }
    ++clock;
}


ptr<Monster> HitMonster(ptr<Movable> pMovable)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte status = pMonster->status;
        if ((status & Movable_Live) != 0 && (status & Movable_Loose) == 0) {
            if (IsNear(pMovable, pMonster)) {
                pMonster->status =
                    (status & Movable_Pattern) |
                    (Movable_Live | Monster_Visible | Movable_Loose);
                Show(pMonster);
                UpdateMonsterTargets();
                return pMonster;
            }
        }
    }
    return nullptr;
}