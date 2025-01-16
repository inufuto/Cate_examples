#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Status.h"
#include "Main.h"
#include "Sound.h"
#include "Man.h"
#include "Vram.h"

extern void _deb();

constexpr byte SpriteColor = 13;
constexpr byte Monster_Visible = 0x40;

// Monster[MaxMonsterCount] Monsters;
byte MonsterCount;


void InitMonsters()
{
    word pMonster = Monsters;
    byte count = pStage->enemyCount;
    byte i = 0;
    byte sprite = Sprite_Monster;
    while (i < count) {
        WriteVram(pMonster + Movable_status, Movable_Live | Monster_Visible);
        WriteVram(pMonster + Movable_sprite, sprite);
        ++sprite;
        pMonster += Monster_unitSize;
        ++i;
    }
    while (i < MaxMonsterCount) {
        WriteVram(pMonster + Movable_status, 0);
        WriteVram(pMonster + Movable_sprite, sprite);
        HideSprite(sprite);
        ++sprite;
        pMonster += Monster_unitSize;
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
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Movable_status);
        if ((status & Movable_Live) != 0 && (status & Movable_Loose) == 0) {
            bool done = false;
            do {
                if ((cell & Cell_Food) != 0) {
                    WriteVram(pMonster + Monster_targetX, ToCoord(column) << CoordShift);
                    WriteVram(pMonster + Monster_targetY, ToCoord(row) << CoordShift);
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
        pMonster += Monster_unitSize;
    }
}


static void Show(word pMonster)
{
    if ((ReadVram(pMonster + Movable_status) & Monster_Visible) != 0) {
        ShowMovable(pMonster, Pattern_Monster, SpriteColor);
    }
    else {
        // ShowMovable(pMonster, Pattern_Monster, 4);
        HideSprite(ReadVram(pMonster + Movable_sprite));
    }
}

static void DecideDirection(word pMonster)
{
    static ptr<Direction>[4] directionPtrs;

    byte x = ReadVram(pMonster + Movable_x);
    byte y = ReadVram(pMonster + Movable_y);
    byte targetX = ReadVram(pMonster + Monster_targetX);
    byte targetY = ReadVram(pMonster + Monster_targetY);
    if (Abs(targetX, x) > Abs(targetY, y)) {
        ptr<ptr<Direction> > p1, p2;
        if (targetX < x) {
            sbyte dx = ReadVram(pMonster + Movable_dx);
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
            sbyte dx = ReadVram(pMonster + Movable_dx);
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
        sbyte dy = ReadVram(pMonster + Movable_dy);
        if (targetY <= y && dy <= 0) {
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
        if (targetY < y) {
            sbyte dy = ReadVram(pMonster + Movable_dy);
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
            sbyte dy = ReadVram(pMonster + Movable_dy);
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
        sbyte dx = ReadVram(pMonster + Movable_dx);
        if (targetX <= y && dx <= 0) {
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
    WriteVram(pMonster + Movable_dx, 0);
    WriteVram(pMonster + Movable_dy, 0);
}

void StartMonsters()
{
    UpdateMonsterTargets();
    MonsterCount = 0;
                                _deb();
    ptr<byte> pByte = pStage->pEnemies;
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Movable_status);
        if ((status & Movable_Live) != 0) {
            WriteVram(pMonster + Movable_status, status | Monster_Visible);
            WriteVram(pMonster + Movable_dx, 0);
            WriteVram(pMonster + Movable_dy, 0);
            LocateMovable(pMonster, *pByte);
            DecideDirection(pMonster);
            Show(pMonster);
            ++MonsterCount;
        }
        ++pByte;
        pMonster += Monster_unitSize;
    }
}


void MoveMonsters()
{
    static byte clock;
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Movable_status);
        if ((status & Movable_Live) != 0) {
            if ((status & Movable_Loose) == 0) {
                MoveMovable(pMonster);
                if (IsOnGrid(pMonster)) {
                    status &= ~Monster_Visible;
                    WriteVram(pMonster + Movable_status, status);
                    byte column = ToGrid(ReadVram(pMonster + Movable_x));
                    byte row = ToGrid(ReadVram(pMonster + Movable_y));
                    byte cell = GetCell(column, row);
                    if ((cell & Cell_Dot) != 0) {
                        SetCell(column, row, cell & ~Cell_Dot);
                    }
                    else if ((cell & Cell_Food) != 0) {
                        status |= Monster_Visible;
                        WriteVram(pMonster + Movable_status, status);
                        SetCell(column, row, cell & ~Cell_Food);
                        --FoodCount;
                        PrintFoodCount();
                        Sound_Stole();
                        UpdateMonsterTargets();
                    }
                    DecideDirection(pMonster);
                }
                byte manStatus = ReadVram(Man + Movable_status);
                if ((manStatus & Movable_Loose) == 0 && IsNear(pMonster, Man)) {
                    manStatus &= ~Movable_Live;
                    WriteVram(Man + Movable_status, manStatus);
                    status |= Monster_Visible;
                    WriteVram(pMonster + Movable_status, status);
                }
            }
            else {
                if ((clock & CoordMask) == 0) {
                    status += 2;
                    if ((status & Movable_Pattern) == 0) {
                        WriteVram(pMonster + Movable_status, status & ~Movable_Live);
                        HideSprite(ReadVram(pMonster + Movable_sprite));
                        --MonsterCount;
                        goto next;
                    }
                    WriteVram(pMonster + Movable_status, status);
                }
            }
            Show(pMonster);
            next:;
        }
        pMonster += Monster_unitSize;
    }
    ++clock;
}


word HitMonster(word pMovable)
{
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Movable_status);
        if ((status & Movable_Live) != 0 && (status & Movable_Loose) == 0) {
            if (IsNear(pMovable, pMonster)) {
                WriteVram(pMonster + Movable_status,
                    (status & Movable_Pattern) |
                    (Movable_Live | Monster_Visible | Movable_Loose)
                );
                Show(pMonster);
                UpdateMonsterTargets();
                return pMonster;
            }
        }
        pMonster += Monster_unitSize;
    }
    return 0;
}