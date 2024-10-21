#include "Robo.h"
#include "Sprite.h"
#include "Direction.h"
#include "Stage.h"
#include "ScanKeys.h"
#include "Fort.h"
#include "Bang.h"
#include "Main.h"
#include "Sound.h"
#include "Chars.h"
#include "Vram.h"

constexpr byte BulletInterval = 20;

Robo MyRobo;
byte ScrollTarget;
static const byte[] ScrollPositions = {
    0,1,1,2,3,4,4,5,6,7,7,8,9,9,10,11,12,12,13,14,15,15,16,17,17,18,19,20,20,21,22,23,23,24,25,25,26,27,28,28,29,30,31,31,32
};
static byte IntervalCount;
static byte RespawnCount;
static byte RespawnTime;

static void Draw()
{
    byte status;
    status = MyRobo.status & Robo_Status_Mask;
    if (
        status == Robo_Status_Live || 
        (status == Robo_Status_Wait && (RespawnCount & 4) == 0)
    ) {
        ScrollTarget = ScrollPositions[MyRobo.x >> 2];
        ShowSprite(Sprite_MyRobo, MyRobo.x, MyRobo.y + StageTop * CoordRate, 
            Pattern_MyRobo + (MyRobo.status & Robo_Pattern_Mask));
    }
    else {
        HideSprite(Sprite_MyRobo);
    }
}


void StartMyRobo(byte status)
{
    RespawnTime = (CurrentStage + 1) << 1;
    if (StartRobo(&MyRobo, MyFort.x, MyFort.y)) {
        MyRobo.status = status;
        SetRoboDirection(&MyRobo, Direction_Right);
        Draw();
        if (status == Robo_Status_Live) {
            HScroll = ScrollTarget;
        }
        IntervalCount = 0;
        RespawnCount = 0;
    }
}


static const byte[] KeyCodes = {
    Keys_Right, Keys_Left, Keys_Down, Keys_Up
};

void MoveMyRobo()
{
    byte status;
    status = MyRobo.status & Robo_Status_Mask;
    if (status != Robo_Status_Live) {
        if (status == Robo_Status_None) {
            StartMyRobo(Robo_Status_Wait);
        }
        --RespawnCount;
        if (RespawnCount == 0) {
            MyRobo.status = (MyRobo.status & ~Robo_Status_Mask) | Robo_Status_Live;
        }
        Draw();
        return;
    }
    if ((MyRobo.x & CoordMask) == 0 && (MyRobo.y & CoordMask) == 0) {
        byte key, direction;
        ptr<byte> pKeyCode;
        key = ScanKeys();
        if ((key & Keys_Button0) != 0) {
            if (IntervalCount == 0) {
                Fire(&MyRobo, true);
                Sound_Fire();
                IntervalCount = BulletInterval;
            }
            else if (IntervalCount != 0) {
                --IntervalCount;
            }
        }
        else {
            IntervalCount = 0;
        }

        direction = 0;
        for (pKeyCode: KeyCodes) {
            if ((key & *pKeyCode) != 0) {
                byte wall;
                wall = TestMoveRobo(&MyRobo, direction);
                if (wall >= Wall_Hard && wall < Wall_EnemyRobo) {
                    byte oldDirection;
                    oldDirection = MyRobo.status & Robo_Direction_Mask;
                    if (TestMoveRobo(&MyRobo, oldDirection) == 0) goto move;
                }
                SetRoboDirection(&MyRobo, direction);
                
                if (wall != 0) goto draw;
                goto move;
            }
            direction += 2;
        }
        cannot:
        MyRobo.status &= ~Robo_CanMove_Mask;
        return;
    }
    move:
    MoveRobo(&MyRobo);
    draw:
    Draw();
}


bool HitMyRoboR(ptr<Robo> pRobo, byte x, byte y)
{
    return
        (MyRobo.status & Robo_Status_Mask) != Robo_Status_None &&
        pRobo != &MyRobo && 
        HitRoboR(&MyRobo, x, y);
}


bool HitMyRoboB(ptr<Bullet> pBullet)
{
    if (!HitRoboB(&MyRobo, pBullet)) return false;
    if (
        (pBullet->status & Bullet_Side_Mask) != Bullet_Side_My &&
        (MyRobo.status & Robo_Status_Mask) == Robo_Status_Live
    ) {
        StartBang(MyRobo.x, MyRobo.y, false);
        Sound_SmallBang();
        MyRobo.status &= ~Robo_Status_Mask;
        RespawnCount = RespawnTime;
        Draw();
    }
    return true;
}


void UpdateScroll()
{
    if (HScroll > ScrollTarget) {
        --HScroll;
    }
    else if (HScroll < ScrollTarget) {
        ++HScroll;
    }
}
