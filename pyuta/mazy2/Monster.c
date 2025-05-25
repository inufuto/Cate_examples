#include "Monster.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Math.h"
#include "Man.h"
#include "Knife.h"
#include "Sound.h"
#include "Point.h"
#include "Vram.h"

extern void _deb();

constexpr byte DisturberColor = 9;
constexpr byte ChaserColor = 13;
constexpr byte Visible = 0x08;
constexpr byte FloorMask = 0x70;
constexpr byte TypeMask = 0x03;
constexpr byte FloorShift = 4;

constexpr byte Type_Horizontal = 0x00;
constexpr byte Type_Vertical = 0x01;
constexpr byte Type_Chaser = 0x02;

// Monster[MaxMonsterCount] Monsters;

void InitMonsters()
{
    word pMonster = Monsters;
    byte totalCount = MaxMonsterCount;
    byte floor = 0;
    ptr<Floor> pFloor = pStage->pFloors;
    byte floorCount = pStage->floorCount;
    do {
        byte sprite = Sprite_Monster;
        byte count = pFloor->monsterCount;
        ptr<byte> pSource = pFloor->pMonsters;
        do {
            WriteVram(pMonster + Movable_sprite, sprite); ++sprite;
            byte position = *pSource; ++pSource;
            LocateMovable(pMonster, position);
            byte type = *pSource; ++pSource;
            WriteVram(pMonster + Movable_status, Movable_Live | type | (floor << FloorShift));
            pMonster += Monster_unitSize;
            --totalCount;
        } while (--count != 0);
        ++floor;
        ++pFloor;
    } while (--floorCount != 0);
    while (totalCount != 0) {
        WriteVram(pMonster + Movable_status, 0);
        pMonster += Monster_unitSize;
        --totalCount;
    }
}

static void UpdateVisiblity(word pMonster)
{
    byte cell = ReadVram(CellMapPtr(ToGrid(ReadVram(pMonster + Movable_x)), ToGrid(ReadVram(pMonster + Movable_y))));
    byte status = ReadVram(pMonster + Movable_status);
    if ((cell & Cell_Visible) != 0) {
        status |= Visible;
    }
    else {
        status &= ~Visible;
    }
    WriteVram(pMonster + Movable_status, status);
}

static void Show(word pMonster)
{
    byte status = ReadVram(pMonster + Movable_status);
    if ((status & Visible) != 0) {
        byte pattern, color;
        if ((status & TypeMask) == Type_Chaser) {
            pattern = Pattern_Chaser;
            color = ChaserColor;
        }
        else {
            pattern = Pattern_Disturber;
            color = DisturberColor;
        }
        ShowSprite(pMonster, pattern, color);
    }
    else {
        HideSprite(ReadVram(pMonster + Movable_sprite));
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
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        if ((ReadVram(pMonster + Movable_status) & (Movable_Live | FloorMask)) == floorFilter) {
            UpdateVisiblity(pMonster);
            Show(pMonster);
        }
        pMonster += Monster_unitSize;
    }
}


static bool IsNearNext(word pMonster, sbyte dx, sbyte dy) 
{
    byte x = ReadVram(pMonster + Movable_x) + dx;
    byte y = ReadVram(pMonster + Movable_y) + dy;
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    word pOther = Monsters;
    repeat (MaxMonsterCount) {
        if (
            pOther != pMonster &&
            (ReadVram(pOther + Movable_status) & (Movable_Live | Visible | FloorMask)) == floorFilter
        ) {
            byte ox = ReadVram(pOther + Movable_x);
            byte oy = ReadVram(pOther + Movable_y);
            if (
                x + CoordRate * 2 - 1 >= ox && ox + CoordRate * 2 - 1 >= x &&
                y + CoordRate * 2 - 1 >= oy && oy + CoordRate * 2 - 1 >= y
            ) {
                return true;
            }
        }
        pOther += Monster_unitSize;
    }
    return false;
}

void MoveMonsters()
{
    static byte clock;
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Movable_status);
        if ((status & (Movable_Live | Visible | FloorMask)) == floorFilter) {
            if (((ReadVram(pMonster + Movable_x) | ReadVram(pMonster + Movable_y)) & CoordMask) == 0) {
                sbyte dx = 0;
                sbyte dy = 0;
                switch (status & TypeMask)
                {
                case Type_Horizontal:
                    dx = Sign(ReadVram(pMonster + Movable_x), ReadVram(Man + Movable_x));
                    break;
                case Type_Vertical:
                    dy = Sign(ReadVram(pMonster + Movable_y), ReadVram(Man + Movable_y));
                    break;
                default:
                    dx = Sign(ReadVram(pMonster + Movable_x), ReadVram(Man + Movable_x));
                    if (dx == 0 || !CanMove(pMonster, dx, dy)) {
                        dx = 0;
                        dy = Sign(ReadVram(pMonster + Movable_y), ReadVram(Man + Movable_y));
                    }
                    break;
                }
                if (!CanMove(pMonster, dx, dy) || IsNearNext(pMonster, dx, dy)) {
                    dx = 0;
                    dy = 0;
                }
                WriteVram(pMonster + Movable_dx, dx);
                WriteVram(pMonster + Movable_dy, dy);
            }
            if ((clock & 1) == 0 || (status & TypeMask) != Type_Chaser) {
                MoveMovable(pMonster);
                Show(pMonster);
                byte x = ReadVram(pMonster + Movable_x);
                byte y = ReadVram(pMonster + Movable_y);
                byte manX = ReadVram(Man + Movable_x);
                byte manY = ReadVram(Man + Movable_y);
                if (
                    ((x | y) & CoordMask) == 0 &&
                    manX + HitRange >= x && x + HitRange >= manX &&
                    manY + HitRange >= y && y + HitRange >= manY
                ) {
                    WriteVram(Man + Movable_status, ReadVram(Man + Movable_status) & ~Movable_Live);
                }
            }
        }
        pMonster += Monster_unitSize;
    }
    ++clock;
}


bool HitMonsters(word pKnife)
{
    byte floorFilter = (CurrentFloor << FloorShift) | Movable_Live | Visible;
    word pMonster = Monsters;
    repeat (MaxMonsterCount) {
        byte status = ReadVram(pMonster + Movable_status);
        if ((status & (Movable_Live | Visible | FloorMask)) == floorFilter) {
            byte x = ReadVram(pMonster + Movable_x);
            byte y = ReadVram(pMonster + Movable_y);
            byte kx = ReadVram(pKnife + Movable_x);
            byte ky = ReadVram(pKnife + Movable_y);
            if (
                kx + HitRange / 2 >= x && x + HitRange >= kx &&
                ky + HitRange / 2 >= y && y + HitRange >= ky
            ) {
                Sound_Hit();
                WriteVram(pMonster + Movable_status, status & ~Movable_Live);
                StartPoint(x, y);
                HideSprite(ReadVram(pMonster + Movable_sprite));
                return true;
            }
        }
        pMonster += Monster_unitSize;
    }
    return false;
}
