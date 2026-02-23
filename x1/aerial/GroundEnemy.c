#include "GroundEnemy.h"
#include "Sprite.h"
#include "Chars.h"
#include "Stage.h"
#include "MyBullet.h"
#include "Sound.h"
#include "Bang.h"
#include "Main.h"
#include "Math.h"
#include "MyFighter.h"
#include "EnemyBullet.h"
#include "Item.h"

constexpr byte Color = 14;
constexpr byte Count = Sprite_MyBullet - Sprite_GroundEnemy;
constexpr byte InvalidY = 0xff;
constexpr byte RangeX = (StageWidth - 1);
constexpr byte RangeY = (StageHeight - 1);
constexpr byte FireMask = (1 << 2) - 1;

constexpr byte Type_Track = 0;
constexpr byte Type_Rocket = 1;

struct Type {
    byte pattern;
    byte point;
};

static const Type[] types = {
    { Char_Track, 5 },
    { Char_Rocket, 20 },
};

GroundEnemy[Count] GroundEnemies;

void InitGroundEnemies()
{
    byte sprite;
    ptr<GroundEnemy> pEnemy;
    sprite = Sprite_GroundEnemy;
    for (pEnemy : GroundEnemies) {
        pEnemy->_.sprite = sprite;
        pEnemy->_.y = InvalidY;
        ++sprite;
    }
}


static void Show(ptr<GroundEnemy> pEnemy)
{
    ptr<Type> pType;
    pType = types + (pEnemy->type & 0x0f);
    ShowSprite(&pEnemy->_, pType->pattern);
}


static void End(ptr<GroundEnemy> pEnemy)
{
    pEnemy->_.y = InvalidY;
    HideSprite(pEnemy->_.sprite);
}


void StartGroundEnemy(byte y, byte type)
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        ptr<Type> pType;
        if (pEnemy->_.y != InvalidY) continue;
        pType = types + (pEnemy->type & 0x0f);
        pEnemy->type = type;
        pEnemy->_.x = RangeX;
        pEnemy->_.y = (y - 2);
        pEnemy->_.clock = 0;
        Show(pEnemy);
        return;
    }
}


void ScrollGroundEnemies()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->_.y == InvalidY) continue;
        --pEnemy->_.x;
        if (
            pEnemy->_.x < RangeX && 
            !HitMovableMyFighter(pEnemy->_.x, pEnemy->_.y)
        ) {
            Show(pEnemy);
        }
        else {
            End(pEnemy);
        }
    }
}


void MoveGroundEnemies()
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->_.y == InvalidY) continue;
        switch (pEnemy->type) {
        case Type_Track:
            // if ((pEnemy->_.clock & CoordMask) == 0) {
                if (
                    (pEnemy->_.clock & FireMask) == 0 &&
                    (Rnd()) < CurrentStage + 1 &&
                    MyFighter.x < pEnemy->_.x
                ) {
                    ptr<Bullet> pBullet;
                    byte x, y;
                    x = pEnemy->_.x + 1;
                    y = pEnemy->_.y;
                    pBullet = StartEnemyBullet(x << BulletShift, y << BulletShift);
                    if (pBullet != nullptr) {
                        byte lx, ly;
                        pBullet->dx = -1;
                        pBullet->dy = -1;
                        lx = Abs(x, MyFighter.x);
                        ly = Abs(y, MyFighter.y);
                        if (lx >> 1 <= ly) {
                            pBullet->numeratorX = ShortVelocity * 4 / 3;
                            pBullet->numeratorY = LongVelocity * 4 / 3;
                        }
                        else if (ly >> 1 <= lx) {
                            pBullet->numeratorX = LongVelocity * 4 / 3;
                            pBullet->numeratorY = ShortVelocity * 4 / 3;
                        }
                        else {
                            pBullet->numeratorX = LoVelocity * 4 / 3;
                            pBullet->numeratorY = LoVelocity * 4 / 3;
                        }
                    }
                }
            // }
            break;
        case Type_Rocket:
            // if ((pEnemy->_.clock & CoordMask) == 0) {
                if (
                    pEnemy->_.x - (pEnemy->_.y >> 1) < RangeX / 3 ||
                    Rnd() == 0
                ) {
                    pEnemy->type |= 0x80;
                }
            // }
            break;
        case Type_Rocket | 0x80:
            if (
                --pEnemy->_.y < RangeY &&
                !HitMovableMyFighter(pEnemy->_.x, pEnemy->_.y)
            ) {
                Show(pEnemy);
            }
            else {
                End(pEnemy);
            }
            break;
        }
        ++pEnemy->_.clock;
    }
}


bool HitBulletGroundEnemy(byte x, byte y)
{
    ptr<GroundEnemy> pEnemy;
    for (pEnemy : GroundEnemies) {
        if (pEnemy->_.y == InvalidY) continue;
        if (HitMyBullet(&pEnemy->_, x, y)) {
            ptr<Type> pType;
            if (
                RemainCount < 10 && 
                pEnemy->type == (Type_Rocket | 0x80) &&
                (Rnd() & 1) == 0
            ) {
                StartItem(pEnemy->_.x, pEnemy->_.y);
            }
            pType = types + (pEnemy->type & 0x0f);
            Sound_SmallBang();
            // Sound_Hit();
            StartSmallBang(pEnemy->_.x + 1, pEnemy->_.y + 1);
            End(pEnemy);
            AddScore(pType->point);
            return true;    
        }
    }
    return false;
}
