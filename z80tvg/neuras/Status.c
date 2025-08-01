#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "VVram.h"
#include "Print.h"

constexpr byte Status_X = 32;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize + Status_X * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + Status_X * VramStep, "HIGH");
    PrintS(Vram + VramRowSize * 5 + Status_X * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 8 + Status_X * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + (Status_X + 3) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 11 + Status_X * VramStep, "TIME");

    {
        ptr<byte> pVram;
        byte count;
        pVram = Vram + VramRowSize * 21 + Status_X * VramStep;

        for (count = 1; count < RemainSolverCount; ++count) {
            Put2C(pVram, Char_Solver_Left);
            pVram += 2 * VramStep;
        }
        for (; count < 3; ++count) {
            Erase2(pVram);
            pVram += 2 * VramStep;
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + Status_X * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + Status_X * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + (Status_X + 1) * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + VramRowSize * 18 + Status_X * VramStep, pattern);
    }
    else {
        Erase2(Vram + VramRowSize * 18 + Status_X * VramStep);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
    PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
    PresentVram();
}

void Title()
{
    ClearScreen(); 
    // {
    //     ptr<byte> pByte;
    //     word count;

    //     pByte = Backgnd;
    //     count = StageWidth * StageHeight;
    //     do {
    //         *pByte = Char_Space;
    //         ++pByte;
    //         --count;
    //     } while (count !=0);
    // } 
    {
        byte c;
        ptr<byte> pVram;
        
        c = Char_Title;
        pVram = Vram + VramRowSize * 2 + 10 * VramStep;
        repeat(6) {
            Put2C(pVram, c);
            c += 4;
            pVram += 2 * VramStep;
        }
    } 
    Put2C(Vram + VramRowSize * 8 + 9 * VramStep, Char_Solver_Left);
    Put2C(Vram + VramRowSize * 11 + 9 * VramStep, Char_Monster_Left);
    Put2C(Vram + VramRowSize * 14 + 9 * VramStep, Char_Card);

    PrintStatus();
    PrintS(Vram + VramRowSize * 6 + 7 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 9 + 13 * VramStep, "SOLVER");
    PrintS(Vram + VramRowSize * 12 + 13 * VramStep, "MONSTER");
    PrintS(Vram + VramRowSize * 15 + 13 * VramStep, "CARD");
    PrintS(Vram + VramRowSize * 21 + 6 * VramStep, "PUSH TRIGGER BUTTON");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}