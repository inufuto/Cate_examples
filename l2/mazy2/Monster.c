#include "Monster.h"
#include "Stages.h"
#include "Sprite.h"
#include "Math.h"
#include "Man.h"
#include "Knife.h"
#include "Sound.h"
#include "Point.h"

extern void _deb();

constexpr byte Visible = 0x08;
constexpr byte FloorMask = 0x70;
constexpr byte TypeMask = 0x03;
constexpr byte FloorShift = 4;

constexpr byte Type_Horizontal = 0x00;
constexpr byte Type_Vertical = 0x01;
constexpr byte Type_Chaser = 0x02;

Monster[MaxMonsterCount] Monsters;

void InitMonsters()
{
    ptr<Monster> pMonster = Monsters;
    byte totalCount = MaxMonsterCount;
    byte floor = 0;
    ptr<Floor> pFloor = pStage->pFloors;
    byte floorCount = pStage->floorCount;
    do {
        byte sprite = Sprite_Monster;
        byte count = pFloor->monsterCount;
        ptr<byte> pSource = pFloor->pMonsters;
        do {
            pMonster->sprite = sprite; ++sprite;
            byte position = *pSource; ++pSource;
            LocateMovable(pMonster, position);
            byte type = *pSource; ++pSource;
            pMonster->status = Movable_Live | type | (floor << FloorShift);
            ++pMonster;
            --totalCount;
        } while (--count != 0);
        ++floor;
        ++pFloor;
    } while (--floorCount != 0);
    while (totalCount != 0) {
        pMonster->status = 0;
        ++pMonster;
        --totalCount;
    }
}

static void UpdateVisiblity(ptr<Monster> pMonster)
{
    byte cell = *CellMapPtr(ToGrid(pMonster->x), ToGrid(pMonster->y));
    if ((cell & Cell_Visible) != 0) {
        pMonster->status |= Visible;
    }
    else {
        pMonster->status &= ~Visible;
    }
}

static void Show(ptr<Monster> pMonster)
{
    byte status = pMonster->status;
    if ((status & Visible) != 0) {
        ptr<byte> pChars;
        if ((status & TypeMask) == Type_Chaser) {
            static const byte[] Chars = {
                0x94, 0x94, 0x07, 0x05,
            };
            pChars = Chars;
        }
        else {
            static const byte[] Chars = {
                0xe5, 0xe5, 0x07, 0x05,
            };
            pChars = Chars;
        }
        ShowSprite(pMonster, pChars);
    }
    else {
        HideSprite(pMonster->sprite);
    }
}


void ShowMonsters()
{
    byte sprite = Sprite_Monster;
    repeat (MaxMonsterCountOfFloor) {
        HideSprite(sprite);
        ++sprite;
    }
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live;
    ptr<Monster> pMonster;
    for (pMonster: Monsters) {
        if ((pMonster->status & (Movable_Live | FloorMask)) == floorFilter) {
            UpdateVisiblity(pMonster);
            Show(pMonster);
        }
    }
}


static bool IsNearNext(ptr<Monster> pMonster, sbyte dx, sbyte dy) 
{
    byte x = pMonster->x + dx;
    byte y = pMonster->y + dy;
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    ptr<Monster> pOther;
    for (pOther: Monsters) {
        if (
            pOther != pMonster &&
            (pOther->status & (Movable_Live | Visible | FloorMask)) == floorFilter
        ) {
            byte ox = pOther->x;
            byte oy = pOther->y;
            if (
                x + CoordRate * 2 - 1 >= ox && ox + CoordRate * 2 - 1 >= x &&
                y + CoordRate * 2 - 1 >= oy && oy + CoordRate * 2 - 1 >= y
            ) {
                return true;
            }
        }
    }
    return false;
}

void MoveMonsters()
{
    static byte clock;
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    ptr<Monster> pMonster;
    for (pMonster: Monsters) {
        byte status = pMonster->status;
        if ((status & (Movable_Live | Visible | FloorMask)) == floorFilter) {
            if (((pMonster->x | pMonster->y) & CoordMask) == 0) {
                sbyte dx = 0;
                sbyte dy = 0;
                switch (status & TypeMask)
                {
                case Type_Horizontal:
                    dx = Sign(pMonster->x, Man.x);
                    break;
                case Type_Vertical:
                    dy = Sign(pMonster->y, Man.y);
                    break;
                default:
                    dx = Sign(pMonster->x, Man.x);
                    if (dx == 0 || !CanMove(pMonster, dx, dy)) {
                        dx = 0;
                        dy = Sign(pMonster->y, Man.y);
                    }
                    break;
                }
                if (!CanMove(pMonster, dx, dy) || IsNearNext(pMonster, dx, dy)) {
                    dx = 0;
                    dy = 0;
                }
                pMonster->dx = dx;
                pMonster->dy = dy;
            }
            if ((clock & 1) == 0 || (status & TypeMask) != Type_Chaser) {
                MoveMovable(pMonster);
                Show(pMonster);
                byte x = pMonster->x;
                byte y = pMonster->y;
                if (
                    ((x | y) & CoordMask) == 0 &&
                    Man.x + HitRange >= pMonster->x && pMonster->x + HitRange >= Man.x &&
                    Man.y + HitRange >= pMonster->y && pMonster->y + HitRange >= Man.y
                ) {
                    Man.status &= ~Movable_Live;
                }
            }
        }
    }
    ++clock;
}


bool HitMonsters(ptr<Knife> pKnife)
{
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    ptr<Monster> pMonster;
    for (pMonster: Monsters) {
        if ((pMonster->status & (Movable_Live | Visible | FloorMask)) == floorFilter) {
            if (
                pKnife->x + HitRange / 2 >= pMonster->x && pMonster->x + HitRange >= pKnife->x &&
                pKnife->y + HitRange / 2 >= pMonster->y && pMonster->y + HitRange >= pKnife->y
            ) {
                Sound_Hit();
                pMonster->status &= ~Movable_Live;
                StartPoint(pMonster->x, pMonster->y);
                HideSprite(pMonster->sprite);
                return true;
            }
        }
    }
    return false;
}
