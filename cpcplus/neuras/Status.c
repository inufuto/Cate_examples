#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

constexpr byte Status_X = 32;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramWidth + Status_X * VramStep, "SCORE");
    PrintS(Vram + VramWidth * 4 + Status_X * VramStep, "HIGH");
    PrintS(Vram + VramWidth * 5 + Status_X * VramStep, "SCORE");
    PrintS(Vram + VramWidth * 8 + Status_X * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramWidth * 9 + (Status_X + 3) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramWidth * 11 + Status_X * VramStep, "TIME");

    {
        ptr<byte> pVram;
        byte count;
        pVram = Vram + VramWidth * 21 + Status_X * VramStep;

        for (count = 1; count < RemainSolverCount; ++count) {
            pVram = Put2C(pVram, Char_Solver);
        }
        for (; count < 3; ++count) {
            pVram = Erase2(pVram);
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramWidth * 2 + Status_X * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramWidth * 6 + Status_X * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramWidth * 12 + (Status_X + 1) * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + VramWidth * 18 + Status_X * VramStep, pattern);
    }
    else {
        Erase2(Vram + VramWidth * 18 + Status_X * VramStep);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramWidth * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramWidth * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen();
    HideAllSprites();
    {
        byte c;
        ptr<byte> pVram;
        
        c = Char_N;
        pVram = Vram + VramWidth * 2 + 10 * VramStep;
        repeat(6) {
            pVram = Put2C(pVram, c);
            c += 4;
        }
    } 
    Put2C(Vram + VramWidth * 8 + 9 * VramStep, Char_Solver);
    Put2C(Vram + VramWidth * 11 + 9 * VramStep, Char_Monster);
    Put2C(Vram + VramWidth * 14 + 9 * VramStep, Char_Card);

    PrintStatus();
    PrintS(Vram + VramWidth * 6 + 7 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramWidth * 9 + 13 * VramStep, "SOLVER");
    PrintS(Vram + VramWidth * 12 + 13 * VramStep, "MONSTER");
    PrintS(Vram + VramWidth * 15 + 13 * VramStep, "CARD");
    PrintS(Vram + VramWidth * 21 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 22 + 9 * VramStep, "OR SHIFT KEY");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}