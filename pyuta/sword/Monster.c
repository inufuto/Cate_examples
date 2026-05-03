#include "Monster.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Enemy.h"
#include "Sound.h"
#include "Point.h"
#include "OneUp.h"
#include "Vram.h"

extern void _deb();

constexpr byte Monster_Available = 0x20; 
constexpr byte Monster_Start = 0x40;
constexpr byte Monster_Live = 0x80;

struct Direction {
    sbyte dx, dy;
};
static const Direction[] Directions = {
    { -1, 0 },
    { 1, 0 },
    { 0, -1 },
    { 0, 1 },
};

// Monster[MaxMonsterCount] Monsters;
static word pNextMonster;
static byte NextIndex;
static byte Clock;

static void Next()
{
    pNextMonster += Monster_unitSize;
    ++NextIndex;
    if (NextIndex >= MaxMonsterCount) {
        NextIndex = 0;
        pNextMonster = Monsters;
    }
}

static void Show(word pMonster)
{
    byte pattern = ReadVram(pMonster + Actor_status) & Actor_PatternMask;
    sbyte dx = ReadVram(pMonster + Actor_dx);
    sbyte dy = ReadVram(pMonster + Actor_dy);
    if (dx != 0 || dy != 0) {
        byte seq = ((ReadVram(pMonster + Movable_x) | ReadVram(pMonster + Movable_y)) >> CoordShift) & 1;
        pattern += seq;
    }
    ShowSprite(pMonster, pattern + Pattern_Monster, MonsterColor);
}

void StartMonster()
{
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pNextMonster + Actor_status);
        if (
            (status & Monster_Available) != 0 &&
            (status & (Monster_Start | Monster_Live)) == 0
        ) {
            byte sprite = Sprite_Monster;
            repeat (MonsterSpriteCount) {
                word p = Monsters;
                repeat (MaxMonsterCount) {
                    if (
                        (ReadVram(p + Actor_status) & (Monster_Start | Monster_Live)) != 0 &&
                        ReadVram(p + Movable_sprite) == sprite
                    ) goto inUse;
                    p += Monster_unitSize;
                }
                WriteVram(pNextMonster + Movable_x, ReadVram(pNextMonster + Monster_startX));
                WriteVram(pNextMonster + Movable_y, ReadVram(pNextMonster + Monster_startY));
                WriteVram(pNextMonster + Movable_sprite, sprite);
                WriteVram(pNextMonster + Actor_status, Monster_Start | Monster_Available);
                WriteVram(pNextMonster + Actor_dx, 0);
                WriteVram(pNextMonster + Actor_dy, 0);
                WriteVram(pNextMonster + Monster_count, TimerValue);
                // Show(pNextMonster);
                return;
                
                inUse:
                ++sprite;
            }
            break;
        }
        Next();
    }
}

static void DecideDirection(word pMonster)
{
    static byte[4] directionIndices;

    byte manX = ReadVram(Man + Movable_x);
    byte manY = ReadVram(Man + Movable_y);
    byte monsterX = ReadVram(pMonster + Movable_x);
    byte monsterY = ReadVram(pMonster + Movable_y);
    if (Abs(manX, monsterX) > Abs(manY, monsterY)) {
        byte verticalDirectionIndex;
        if (manX < monsterX) {
            sbyte dx = ReadVram(pMonster + Actor_dx);
            if (dx <= 0) {
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
            sbyte dx = ReadVram(pMonster + Actor_dx);
            if (dx >= 0) {
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
        sbyte dy = ReadVram(pMonster + Actor_dy);
        if (manY < monsterY && dy <= 0 || dy < 0) {
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
        if (manY < monsterY) {
            sbyte dy = ReadVram(pMonster + Actor_dy);
            if (dy <= 0) {
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
            sbyte dy = ReadVram(pMonster + Actor_dy);
            if (dy >= 0) {
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
        sbyte dx = ReadVram(pMonster + Actor_dx);
        if (manX < monsterY && dx <= 0 || dx < 0) {
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
        byte i = 0;
        ptr<byte> pDirectionIndex;
        for (pDirectionIndex: directionIndices) {
            byte index = *pDirectionIndex;
            ptr<Direction> pDirection = Directions + index;
            sbyte dx = pDirection->dx;
            sbyte dy = pDirection->dy;
            if (CanMoveEnemy(pMonster, dx, dy)) {
                WriteVram(pMonster + Actor_dx, dx);
                WriteVram(pMonster + Actor_dy, dy);
                byte pattern = index << 1;
                WriteVram(pMonster + Actor_status, (ReadVram(pMonster + Actor_status) & ~Actor_PatternMask) | pattern);
                return;
            }
            ++i;
        }
    }
    WriteVram(pMonster + Actor_dx, 0);
    WriteVram(pMonster + Actor_dy, 0);
}

void InitMonsters()
{
    {
        byte sprite = Sprite_Monster;
        repeat (MonsterSpriteCount) {
            HideSprite(sprite); ++sprite;
        }
    }
    {
        word pMonster = Monsters;
        byte i = 0;
        ptr<byte> p = pStage->pMonsters;
        byte count = pStage->monsterCount;
        do {
            byte b = *p; ++p;
            LocateActor(pMonster, b);
            WriteVram(pMonster + Actor_status, Monster_Available);
            WriteVram(pMonster + Monster_startX, ReadVram(pMonster + Movable_x));
            WriteVram(pMonster + Monster_startY, ReadVram(pMonster + Movable_y));
            pMonster += Monster_unitSize;
            ++i;
            --count;
        } while (count != 0);
        while (i < MaxMonsterCount) {
            WriteVram(pMonster + Actor_status, 0);
            pMonster += Monster_unitSize;
            ++i;
        }
    }
    pNextMonster = Monsters;
    NextIndex = 0;
    repeat (MonsterSpriteCount) {
        StartMonster();
    }
    {
        word pMonster = Monsters;
        repeat (MaxMonsterCount) {
            byte status = ReadVram(pMonster + Actor_status);
            if ((status & Monster_Start) != 0) {
                WriteVram(pMonster + Actor_status, status | Monster_Live);
                DecideDirection(pMonster);
                Show(pMonster);
            }
            pMonster += Monster_unitSize;
        }
    }
    Clock = 0;
}


void MoveMonsters()
{
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Actor_status);
        if ((status & Monster_Live) != 0) {
            {
                byte mx = ReadVram(pMonster + Movable_x);
                byte my = ReadVram(pMonster + Movable_y);
                if (((mx | my) & GridCoordMask) == 0) {
                    DecideDirection(pMonster);
                    HitMan(mx, my);
                }
            }
            MoveActor(pMonster);
            Show(pMonster);
            {
                byte mx = ReadVram(pMonster + Movable_x);
                byte my = ReadVram(pMonster + Movable_y);
                if (((mx | my) & CoordMask) == 0) {
                    HitMan(mx, my);
                }
            }
        }
        else if ((status & Monster_Start) != 0) {
            if ((Clock & CoordMask) == 0) {
                byte count = ReadVram(pMonster + Monster_count);
                if (count != 0) {
                    if (count << 2 < TimerValue) {
                        if ((count & 1) == 0) {
                            Show(pMonster);
                        }
                        else {
                            HideSprite(ReadVram(pMonster + Movable_sprite));
                        }
                    }
                    WriteVram(pMonster + Monster_count, count - 1);
                }
                else {
                    status &= ~Monster_Start;
                    status |= Monster_Live;
                    WriteVram(pMonster + Actor_status, status);
                    WriteVram(pMonster + Movable_x, ReadVram(pMonster + Monster_startX));
                    WriteVram(pMonster + Movable_y, ReadVram(pMonster + Monster_startY));
                    DecideDirection(pMonster);
                    Show(pMonster);
                }
            }
        }
        pMonster += Monster_unitSize;
    }
    ++Clock;
}


bool IsBlockedByMonster(word pActor, byte column, byte row)
{
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        if (pMonster != pActor) {
            if ((ReadVram(pMonster + Actor_status) & (Monster_Live | Monster_Start)) != 0) {
                byte monsterColumn = (ReadVram(pMonster + Movable_x) >> GridCoordShift);
                byte monsterRow = (ReadVram(pMonster + Movable_y) >> GridCoordShift);
                if (monsterColumn == column && monsterRow == row) {
                    return true;
                }
                sbyte dx = ReadVram(pMonster + Actor_dx);
                sbyte dy = ReadVram(pMonster + Actor_dy);
                if (monsterColumn + dx == column && monsterRow + dy == row) {
                    return true;
                }
            }
        }
        pMonster += Monster_unitSize;
    }
    return false;
}


void HitMonsters(byte x, byte y)
{
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Actor_status);
        if ((status & Monster_Live) != 0) {
            if (IsNear(pMonster, x, y)) {
                WriteVram(pMonster + Actor_status, status & ~(Monster_Live | Monster_Start));
                HideSprite(ReadVram(pMonster + Movable_sprite));
                Sound_Hit();
                StartPoint(ReadVram(pMonster + Movable_x), ReadVram(pMonster + Movable_y));
                StartMonster();
                StartOneUp();
            }
        }
        pMonster += Monster_unitSize;
    }
}
