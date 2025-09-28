#include "Knife.h"
#include "Map.h"
#include "Math.h"
#include "Vram.h"
#include "Chars.h"
#include "Man.h"
#include "Status.h"
#include "Sound.h"
#include "Monster.h"
#include "Main.h"

constexpr byte Status_None = 0;
constexpr byte Status_Floor = 1;
constexpr byte Status_Held = 2;
constexpr byte Status_Flying = 3;

constexpr byte Direction_Left = 0;
constexpr byte Direction_Right = 1;
constexpr byte Direction_Up = 2;
constexpr byte Direction_Down = 3;

constexpr byte Count = 4;

static const sbyte[] Vectors = {
    -1, 0, 1, 0, 0, -1, 0, 1
};

Knife[Count] Knives;
byte HeldKnifeCount;
static bool blink;

static byte DirectionToGoal(ptr<Knife> pKnife)
{
    byte xs, ys;
    if (Abs(GoalX, pKnife->x) >= Abs(GoalY, pKnife->y)) {
        if (GoalX < pKnife->x) {
            return Direction_Left;
        }
        return Direction_Right;
    }
    else {
        if (GoalY < pKnife->y) {
            return Direction_Up;
        }
        return Direction_Down;
    }
}


void InitKnives()
{
    ptr<Knife> pKnife;
    byte count, i;
    count = *pStage; ++pStage;
    i = 0;
    pKnife = Knives;
    while (i < count) {
        byte b;
        pKnife->x = ToMapSize(*pStage); ++pStage;
        b = *pStage;
        pKnife->y = ToMapSize(b & 0x3f); ++pStage;
        pKnife->status = Status_Floor;
        pKnife->direction = DirectionToGoal(pKnife);
        ++pKnife;
        ++i;
    }
    while (i < Count) {
        pKnife->status = Status_None;
        ++pKnife;
        ++i;
    }
    HeldKnifeCount = 0;
    blink = true;
}


void DrawKnives()
{
    ptr<Knife> pKnife;
    blink = !blink;
    for (pKnife : Knives) {
        switch (pKnife->status) {
        case Status_Floor:
            if (!blink) goto draw;
            break;
        case Status_Flying:
            draw:
            VPut1(pKnife->x, pKnife->y, Char_Knife_Left + pKnife->direction);
            break;
        default:
            break;
        }
    }
}


void MoveKnives()
{
    ptr<Knife> pKnife;
    for (pKnife : Knives) {
        byte x, y;
        ptr<sbyte> pDir;
        x = pKnife->x;
        y = pKnife->y;
        switch (pKnife->status) {
        case Status_Floor:
            if (
                x >= ManX && x < ManX + 2 &&
                y >= ManY && y < ManY + 2
            ) {
                pKnife->status = Status_Held;
                ++HeldKnifeCount;
                PrintHeldKnives();
                Sound_Get();
            }
            break;
        case Status_Flying:
            pDir = Vectors + ((pKnife->direction) << 1);
            x += *pDir; ++pDir;
            y += *pDir;
            if (!CanMove1(x, y)) {
                floor:
                pKnife->status = Status_Floor;
                pKnife->direction = DirectionToGoal(pKnife);
            }
            else {
                pKnife->x = x;
                pKnife->y = y;
                if (MonsterHitKnife(x, y)) {
                    DrawAll();
                    Sound_Hit();
                    goto floor;
                }
            }
            break;
        }       
    }
}


void StartKnife(byte x, byte y, byte direction)
{
    ptr<Knife> pKnife;
    for (pKnife : Knives) {
        if (pKnife->status == Status_Held) {
            pKnife->x = x;
            pKnife->y = y;
            pKnife->status = Status_Flying;
            pKnife->direction = direction;
            --HeldKnifeCount;
            PrintHeldKnives();
            Sound_Get();
            return;
        }
    }
}
