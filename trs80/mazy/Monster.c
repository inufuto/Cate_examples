#include "Monster.h"
#include "Map.h"
#include "Chars.h"
#include "VVram.h"
#include "Man.h"
#include "Main.h"
#include "Sound.h"

constexpr byte Status_None = 0;
constexpr byte Status_Live = 1;
constexpr byte Status_End = 2;

constexpr byte Type_Horizontal = 0;
constexpr byte Type_Vertical = 1;
constexpr byte Type_Chase = 2;

constexpr byte Count = 8;

Monster[Count] Monsters;

void InitMonsters()
{
    ptr<Monster> pMonster;
    byte count, i;
    count = *pStage; ++pStage;
    i = 0;
    pMonster = Monsters;
    while (i < count) {
        byte b;
        pMonster->x = ToMapSize(*pStage); ++pStage;
        b = *pStage;
        pMonster->y = ToMapSize(b & 0x3f); ++pStage;
        pMonster->type = b >> 6;
        pMonster->status = Status_Live;
        ++pMonster;
        ++i;
    }
    while (i < Count) {
        pMonster->status = Status_None;
        ++pMonster;
        ++i;
    }
}


void DrawMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte c;
        switch (pMonster->status) {
        case Status_Live:
            if (pMonster->type == Type_Chase) {
                c = Char_Chaser;
            }
            else {
                c = Char_Disturber;
            }
            VPut2(pMonster->x, pMonster->y, c);
            break;
        case Status_End:
            VPut2(pMonster->x, pMonster->y, Char_Bang);
            break;
        }
    }
}


static void TestHitMan(ptr<Monster> pMonster)
{
    if (
        ManX - pMonster->x + 1 < 3 &&
        ManY - pMonster->y + 1 < 3
    ) {
        ManLost = true;
    }
}


static bool CanMove(ptr<Monster> pMonster, byte x, byte y)
{
    ptr<Monster> pOther;
    if (!CanMove2(x, y)) return false;
    for (pOther : Monsters) {
        if (pOther->status == Status_Live && pOther != pMonster) {
            if (
                x - pOther->x + 1 < 3 &&
                y - pOther->y + 1 < 3
            ) {
                return false;
            }
        }
    }
    return true;
}


void MoveMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        byte x, y;
        
        ++pMonster->clock;
        switch (pMonster->status) {
        case Status_Live:
            TestHitMan(pMonster);
            x = pMonster->x;
            y = pMonster->y;
            switch (pMonster->type) {
            case Type_Horizontal:
                if (x > ManX) {
                    --x;
                }
                else if (x <ManX) {
                    ++x;
                }
                if (CanMove(pMonster, x, y)) goto move;
                break;
            case Type_Vertical:
                if (ManY < y) {
                    --y;
                }
                else if (ManY > y) {
                    ++y;
                }
                if (CanMove(pMonster, x, y)) {
                    move:
                    pMonster->x = x;
                    pMonster->y = y;
                    TestHitMan(pMonster);
                }
                break;
            default:
                if ((pMonster->clock & 1) != 0) {
                    if (x != ManX) {
                        if (x > ManX) {
                            --x;
                        }
                        else  {
                            ++x;
                        }
                        if (CanMove(pMonster, x, y)) goto move;
                        x = pMonster->x;
                    }
                    if (ManY != y) {
                        if (ManY < y) {
                            --y;
                        }
                        else {
                            ++y;
                        }
                        if (CanMove(pMonster, x, y)) goto move;
                    }
                }
            }
            break;
        case Status_End:
            if (pMonster->clock == 4) {
                pMonster->status = Status_None;
            }
            break;
        }
    }
}


bool MonsterHitKnife(byte kx, byte ky)
{
    ptr<Monster> pMonster;
    for (pMonster : Monsters) {
        if (pMonster->status == Status_Live) {
            if (
                kx >= pMonster->x &&
                kx < pMonster->x + 2 &&
                ky >= pMonster->y &&
                ky < pMonster->y + 2
            ) {
                pMonster->status = Status_End;
                pMonster->clock = 0;
                AddScore(pMonster->type == Type_Chase ? 30 : 10);
                return true;
            }
        }
    }
    return false;
}