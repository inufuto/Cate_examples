#include "Solver.h"
#include "ScanKeys.h"
#include "Chars.h"
#include "Sprite.h"
#include "Stage.h"
#include "Card.h"
#include "Sound.h"
#include "Vram.h"
#include "Monster.h"

struct Direction
{
    byte key;
    sbyte dx, dy;
    sbyte pattern;
};

static const Direction[] Directions = {
    { Keys_Left, -1, 0, Pattern_Solver_Left },
    { Keys_Right, 1, 0, Pattern_Solver_Right },
    { Keys_Up, 0, -1, Pattern_Solver_Up },
    { Keys_Down, 0, 1, Pattern_Solver_Down }
};

static const sbyte[4] RotationPatterns = {
    Pattern_Solver_Left,
    Pattern_Solver_Down,
    Pattern_Solver_Right,
    Pattern_Solver_Up
};

byte SolverX;
byte SolverY;
byte SolverStatus;
static ptr<Direction> pDirection;
static bool ButtonOn;

void InitSolver(byte x, byte y) 
{
    SolverX = x;
    SolverY = y;
    SolverStatus = Solver_Status_Live;
    pDirection = Directions;
    ButtonOn = false;

    ShowSpriteC(Sprite_Solver, SolverX, SolverY, pDirection->pattern);
}

static bool Move(ptr<Direction> pNewDirection) 
{
    byte newX, newY, seq;

    newX = SolverX + pNewDirection->dx;
    newY = SolverY + pNewDirection->dy;

    if (TestMap2(newX, newY)) {
        pDirection = pNewDirection;
        SolverX = newX; 
        SolverY = newY;
        seq = ((SolverX + SolverY + 4) >> 2) & 2;
        ShowSpriteC(Sprite_Solver, SolverX, SolverY, pDirection->pattern + seq);
        return true;
    }
    return false;
}

void MoveSolver() 
{
    byte key;
    bool keyOn;

    if (SolverStatus != Solver_Status_Live) return;
    
    key = ScanKeys();
    if ((SolverX & 3) == 0 && (SolverY & 3) == 0) {
        ptr<Direction> pNewDirection;
        keyOn = false;
        for (pNewDirection : Directions) {
            if ((key & pNewDirection->key) != 0) {
                keyOn = true;
                if (Move(pNewDirection)) {
                    goto moved;
                }
            }
        }
    }
    else {
        keyOn = true;
    }    
    if (keyOn) {
        Move(pDirection);
    }
    moved:
    PickCard();
    if ((key & Keys_Button0) != 0) {
        if (!ButtonOn) {
            ptr<Direction> p;
            ButtonOn = true;
            p = pDirection;
            ThrowCard(
                SolverX + (p->dx << 4), SolverY + (p->dy << 4),
                p->dx, p->dy
            );
        }
    } else {
        ButtonOn = false;
    }
}

void EndSolver()
{
    byte i;
    
    i = 0;
    repeat(20) {
        ShowSpriteC(Sprite_Solver, SolverX, SolverY, RotationPatterns[i & 3]);
        ++i;
        // UpdateSprites();
        Sound_Loose();
    }
}