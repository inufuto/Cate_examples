#include "Movable.h"
#include "Actor.h"
#include "Stage.h"
#include "Block.h"
#include "Sprite.h"
#include "Man.h"

extern void _deb();
void MoveActor(ptr<Actor> pActor)
{
    pActor->_.xd += pActor->dx;
    if (pActor->_.xd >= CoordRate) {
        pActor->_.x += pActor->dx;
        pActor->_.xd &= CoordMask;
    }
    MoveActorY(pActor);
}


void MoveActorY(ptr<Actor> pActor)
{
    pActor->_.yd += pActor->dy;
    if (pActor->_.yd >= CoordRate) {
        if (pActor->dy < 0) {
            --pActor->_.y;
            pActor->_.yd += CoordRate;
        }
        else if (pActor->dy > 0) {
            ++pActor->_.y;
            pActor->_.yd -= CoordRate;
        }
    }
    {
        byte seq;
        seq = (pActor->_.x + pActor->_.y);
        pActor->status = (pActor->status & ~Actor_SeqMask) | (seq & Actor_SeqMask);
    }
}


bool CanMove(ptr<Actor> pActor, sbyte dx)
{
    byte y;
    byte yd;
    y = pActor->_.y;
    yd = pActor->_.yd;
    if (yd >= 128 && yd < -(CoordRate - 1)) {
        --y;
    }
    if (dx < 0) {
        return
            pActor->_.x > 0 &&
            !IsWall(pActor->_.x - 1, y) &&
            !HitBlock(pActor->_.x - 1, y);
    }
    else if (dx > 0) {
        return
            pActor->_.x < StageWidth - 2 &&
            !IsWall(pActor->_.x + 2, y) &&
            !HitBlock(pActor->_.x + 1, y);
    }
    return true;
}


void ShowEnemy(ptr<Actor> pActor)
{
    byte seq = pActor->status & 1;
    byte pattern = pActor->pattern + seq;
    ShowSprite(&pActor->_, pattern);
}
