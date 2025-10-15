#include "Monster.h"
#include "Stages.h"
#include "Chars.h"
#include "Sprite.h"
#include "Vram.h"
#include "Man.h"
#include "Main.h"

extern void _deb();

constexpr byte InvalidPattern = 0xff;
// constexpr byte SpriteColor = 13;

Monster[MaxMonsterCount] Monsters;

void InitMonsters()
{
    byte i, n;
    ptr<byte> pByte;
    ptr<Monster> pMonster;
    i = 0;
    n = pStage->monsterCount;
    pByte = pStage->pMonsters;
    pMonster = Monsters;
    while (i < n) {
        byte floor, left, right;
        floor = *pByte; ++pByte;
        pMonster->_.y = FloorToY(floor) + Offset_Head;
        left = ColumnToX(*pByte); ++pByte;
        pMonster->_.x = left;
        pMonster->left = left;
        pMonster->right = ColumnToX(*pByte); ++pByte;
        pMonster->dx = 1;
        pMonster->pattern = Char_Monster_Right;
        ++pMonster;
        ++i;
    }
    while (i < MaxMonsterCount) {
        pMonster->pattern = InvalidPattern;
        ++pMonster;
        ++i;
    }
}


void ShowMonsters()
{
    ptr<Monster> pMonster;
    byte sprite;
    sprite = Sprite_Monster;
    for (pMonster: Monsters) {
        if (pMonster->pattern != InvalidPattern) {
            byte x;
            PollVSync();
            x = pMonster->_.x - LeftX;
            if (x < WindowWidth) {
                pMonster->_.sprite = sprite;
                ShowSprite(&pMonster->_, pMonster->pattern + ((pMonster->_.x & 1) << 2));
                ++sprite;
                if (sprite >= Sprite_Monster_End) return;
            }
        }
    }
    while (sprite < Sprite_Monster_End) {
        HideSprite(sprite);
        ++sprite;
    }
}


static void HitMan(ptr<Monster> pMonster)
{
    if (IsNear(&Man._, &pMonster->_)) {
        Man.status &= ~Man_Live;
    }
}


void MoveMonsters()
{
    ptr<Monster> pMonster;
    for (pMonster: Monsters) {
        if (pMonster->pattern != InvalidPattern) {
            PollVSync();
            HitMan(pMonster);
            if (pMonster->dx > 0) {
                if (MoveX(&pMonster->_, pMonster->dx)) {
                    if (pMonster->_.x == pMonster->right) {
                        pMonster->dx = -1;
                        pMonster->pattern = Char_Monster_Left;
                    }
                }
            }
            else {
                if (MoveX(&pMonster->_, pMonster->dx)) {
                    if (pMonster->_.x == pMonster->left) {
                        pMonster->dx = 1;
                        pMonster->pattern = Char_Monster_Right;
                    }
                }
            }
            HitMan(pMonster);
        }
    }
}