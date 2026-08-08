#include "Monster.h"
#include "Stages.h"
#include "Sprite.h"
#include "Vram.h"
#include "Man.h"

extern void _deb();

constexpr byte InvalidPattern = 0xff;
constexpr byte Index_Left = 0;
constexpr byte Index_Right = 4;
Monster[MaxMonsterCount] Monsters;


static void Show(ptr<Monster> pMonster)
{
    static const byte[] Chars = {
        0xb0, 0xb0, 0xb0, 0xd0,
	    0xe0, 0xe0, 0x70, 0xe0,
    };
    ShowSprite(&pMonster->_, Chars + pMonster->pattern);
}


void InitMonsters()
{
    byte i, n;
    ptr<byte> pByte;
    ptr<Monster> pMonster;
    byte sprite;
    i = 0;
    n = pStage->monsterCount;
    pByte = pStage->pMonsters;
    pMonster = Monsters;
    sprite = Sprite_Monster;
    while (i < n) {
        byte floor, left, right;
        floor = *pByte; ++pByte;
        pMonster->_.y = FloorToY(floor) + Offset_Head;
        left = ColumnToX(*pByte); ++pByte;
        pMonster->_.x = left;
        pMonster->left = left;
        pMonster->right = ColumnToX(*pByte); ++pByte;
        pMonster->dx = 1;
        pMonster->pattern = Index_Right;
        pMonster->_.sprite = sprite;
        Show(pMonster);
        ++sprite;
        ++pMonster;
        ++i;
    }
    while (i < MaxMonsterCount) {
        pMonster->pattern = InvalidPattern;
        ++pMonster;
        ++i;
    }
}


// void ShowMonsters()
// {
//     ptr<Monster> pMonster;
    
//     for (pMonster: Monsters) {
//         if (pMonster->pattern != InvalidPattern) {
//             byte x;
//             x = pMonster->_.x - LeftX;
//             if (x < WindowWidth) {
//                 pMonster->_.sprite = sprite;
//                 ++sprite;
//                 if (sprite >= Sprite_Lift) return;
//             }
//         }
//     }
//     while (sprite < Sprite_Lift) {
//         HideSprite(sprite);
//         ++sprite;
//     }
// }


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
            HitMan(pMonster);
            if (pMonster->dx > 0) {
                if (MoveX(&pMonster->_, pMonster->dx)) {
                    if (pMonster->_.x == pMonster->right) {
                        pMonster->dx = -1;
                        pMonster->pattern = Index_Left;
                    }
                }
            }
            else {
                if (MoveX(&pMonster->_, pMonster->dx)) {
                    if (pMonster->_.x == pMonster->left) {
                        pMonster->dx = 1;
                        pMonster->pattern = Index_Right;
                    }
                }
            }
            Show(pMonster);
            HitMan(pMonster);
        }
    }
}