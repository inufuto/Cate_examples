#include "Movable.h"
#include "Sprite.h"
#include "Actor.h"
#include "Monster.h"
#include "Chars.h"
#include "Math.h"
#include "Main.h"
#include "Stage.h"
#include "Man.h"
#include "VVram.h"

constexpr byte MaxCount = SpriteCount - Sprite_Monster;

Actor[MaxCount] Monsters;

extern void _deb();


void InitMonsters()
{
    ptr<byte> pBytes;
    ptr<Actor> pMonster;
    byte count, i, sprite;
    pBytes = pStage->pMonsters;
    pMonster = Monsters;
    count = pStage->monsterCount;
    i = 0;
    sprite = Sprite_Monster;
    while (i < count) {
        byte b;
        b = *pBytes; ++pBytes;
        pMonster->_.x = ToX(b);
        pMonster->_.y = ToY(b);
        pMonster->_.xd = 0;
        pMonster->_.yd = 0;
        pMonster->dx = -1; // Sign(StageWidth / 2, pMonster->_.x)
        pMonster->dy = 0;
        pMonster->pattern = Pattern_Monster;
        pMonster->status = Actor_Live;
        pMonster->_.sprite = sprite;
        ShowEnemy(pMonster);
        ++sprite;
        ++i;
        ++pMonster;
    }
    while (i < MaxCount) {
        pMonster->status = 0;
        // pMonster->_.sprite = sprite;
        HideSprite(sprite);
        ++sprite;
        ++i;
        ++pMonster;
    }
}


void MoveMonsters()
{
    ptr<Actor> pMonster;
    for (pMonster : Monsters) {
        if ((pMonster->status & Actor_Live) != 0) {
            if (pMonster->_.xd == 0 && pMonster->_.yd == 0) {
                HitMan(pMonster);
                if (IsOnFloor(pMonster->_.y)) {
                    pMonster->dy = 0;
                    if (pMonster->dx < 0) {
                        if (
                            !CanMove(pMonster, -1) ||
                            (
                                (pMonster->_.x & 1) == 0 &&
                                GetCellType(pMonster->_.x - 2, pMonster->_.y) == CellType_Hole
                            )
                        ) {
                            pMonster->dx = 1;
                            pMonster->pattern = Pattern_Monster_Right;
                        }
                        else {
                            pMonster->pattern = Pattern_Monster_Left;
                        }
                    }
                    else if (pMonster->dx > 0) {
                        if (
                            !CanMove(pMonster, 1) ||
                            (
                                (pMonster->_.x & 1) == 0 &&
                                GetCellType(pMonster->_.x + 2, pMonster->_.y) == CellType_Hole
                            )
                        ) {
                            pMonster->dx = -1;
                            pMonster->pattern = Pattern_Monster_Left;
                        }
                        else {
                            pMonster->pattern = Pattern_Monster_Right;
                        }
                    }
                }
            }
            MoveActor(pMonster);
            ShowEnemy(pMonster);
            HitMan(pMonster);
        }
    }
}