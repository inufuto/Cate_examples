#include "Movable.h"
#include "Actor.h"
#include "Stage.h"
#include "Block.h"
#include "Sprite.h"
#include "Man.h"

void MoveActor(ptr<Actor> pActor)
{
    pActor->_.x += pActor->dx;
    MoveActorY(pActor);
}


void MoveActorY(ptr<Actor> pActor)
{
    pActor->_.y += pActor->dy;
    {
        byte seq;
        seq = (pActor->_.x + pActor->_.y);
        pActor->status = (pActor->status & ~Actor_SeqMask) | (seq & Actor_SeqMask);
    }
}


bool CanMove(ptr<Actor> pActor, sbyte dx)
{
    byte y;
    y = pActor->_.y;
    if ((pActor->status & Man_Jump) != 0) {
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
    const byte[] Chars = {
        0x70, 0xd0, 0x70, 0x70, 0x70, 0xd0, 0xd0, 0xd0,
	    0xb0, 0xb0, 0xb0, 0xd0, 0xe0, 0xe0, 0x70, 0xe0,
    };
    ShowSprite(&pActor->_, Chars + pActor->pattern);
}
