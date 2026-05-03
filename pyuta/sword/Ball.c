#include "Ball.h"
#include "Stage.h"
#include "Stages.h"
#include "Sprite.h"
#include "Chars.h"
#include "Enemy.h"
#include "Man.h"
#include "Vram.h"

extern void _deb();

constexpr byte Ball_Live = 0x80;

// Ball[MaxBallCount] Balls;

static void Show(word pBall)
{
    ShowSprite(pBall, Pattern_Ball, BallColor);
}

void InitBalls()
{
    word pBall = Balls;
    byte sprite = Sprite_Ball;
    byte i = 0;
    byte count = pStage->ballCount;
    ptr<byte> p = pStage->pBalls;
    do {
        WriteVram(pBall + Movable_sprite, sprite); ++sprite;
        WriteVram(pBall + Actor_status, Ball_Live);
        LocateActor(pBall, *p); ++p;
        WriteVram(pBall + Actor_dx, 0);
        WriteVram(pBall + Actor_dy, 1);
        Show(pBall);
        pBall += Actor_unitSize;
        ++i;
        --count;
    } while (count !=0);
    while (i < MaxBallCount) {
        HideSprite(sprite); ++sprite;
        WriteVram(pBall + Actor_status, 0);
        pBall += Actor_unitSize;
        ++i;
    }
}


void MoveBalls()
{
    word pBall = Balls;
    repeat (MaxBallCount) {
        if ((ReadVram(pBall + Actor_status) & Ball_Live) != 0) {
            if (((ReadVram(pBall + Movable_x) | ReadVram(pBall + Movable_y)) & GridCoordMask) == 0) {
                byte nextColumn = (ReadVram(pBall + Movable_x) >> GridCoordShift);
                byte nextRow = (ReadVram(pBall + Movable_y) >> GridCoordShift) + 1;
                if (!CanMoveEnemy(pBall, ReadVram(pBall + Actor_dx), ReadVram(pBall + Actor_dy))) {
                    WriteVram(pBall + Actor_dy, -(ReadVram(pBall + Actor_dy)));
                }
                HitMan(ReadVram(pBall + Movable_x), ReadVram(pBall + Movable_y));
            }
            MoveActor(pBall);
            Show(pBall);
            if (((ReadVram(pBall + Movable_x) | ReadVram(pBall + Movable_y)) & CoordMask) == 0) {
                HitMan(ReadVram(pBall + Movable_x), ReadVram(pBall + Movable_y));
            }
        }
        pBall += Actor_unitSize;
    }
}


bool IsBlockedByBall(word pActor, byte column, byte row)
{
    word pBall = Balls;
    repeat (MaxBallCount) {
        if ((ReadVram(pBall + Actor_status) & Ball_Live) != 0 && pBall != pActor) {
            byte ballColumn = (ReadVram(pBall + Movable_x) >> GridCoordShift);
            byte ballRow = (ReadVram(pBall + Movable_y) >> GridCoordShift);
            if (ballColumn == column && ballRow == row) {
                return true;
            }
            sbyte dx = ReadVram(pBall + Actor_dx);
            sbyte dy = ReadVram(pBall + Actor_dy);
            if (ballColumn + (dx >> GridCoordShift) == column && ballRow + (dy >> GridCoordShift) == row) {
                return true;
            }
        }
        pBall += Actor_unitSize;
    }
    return false;
}