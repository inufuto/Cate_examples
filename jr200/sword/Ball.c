#include "Ball.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Enemy.h"
#include "Man.h"

extern void _deb();

constexpr byte Ball_Live = 0x80;

Ball[MaxBallCount] Balls;

static void Show(ptr<Ball> pBall)
{
    ShowSpriteC(pBall, Char_Ball);
}

void InitBalls()
{
    ptr<Ball> pBall = Balls;
    byte sprite = Sprite_Ball;
    byte i = 0;
    byte count = pStage->ballCount;
    ptr<byte> p = pStage->pBalls;
    do {
        pBall->sprite = sprite; ++sprite;
        pBall->status = Ball_Live;
        LocateActor(pBall, *p); ++p;
        pBall->dx = 0;
        pBall->dy = 1;
        Show(pBall);
        ++pBall;
        ++i;
        --count;
    } while (count !=0);
    while (i < MaxBallCount) {
        HideSprite(sprite); ++sprite;
        pBall->status = 0;
        ++pBall;
        ++i;
    }
}


void MoveBalls()
{
    ptr<Ball> pBall;
    for (pBall : Balls) {
        if ((pBall->status & Ball_Live) != 0) {
            if (((pBall->x | pBall->y) & GridCoordMask) == 0) {
                byte nextColumn = (pBall->x >> GridCoordShift);
                byte nextRow = (pBall->y >> GridCoordShift) + 1;
                if (!CanMoveEnemy(pBall, pBall->dx, pBall->dy)) {
                    pBall->dy = -pBall->dy;
                }
                HitMan(pBall->x, pBall->y);
            }
            MoveActor(pBall);
            Show(pBall);
            if (((pBall->x | pBall->y) & CoordMask) == 0) {
                HitMan(pBall->x, pBall->y);
            }
        }
    }
}


bool IsBlockedByBall(ptr<Actor> pActor, byte column, byte row)
{
    ptr<Ball> pBall;
    for (pBall : Balls) {
        if ((pBall->status & Ball_Live) != 0 && pBall != pActor) {
            byte ballColumn = (pBall->x >> GridCoordShift);
            byte ballRow = (pBall->y >> GridCoordShift);
            if (ballColumn == column && ballRow == row) {
                return true;
            }
            if (ballColumn + pBall->dx == column && ballRow + pBall->dy == row) {
                return true;
            }
        }
    }
    return false;
}