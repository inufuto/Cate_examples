#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

constexpr ptr<byte> Status = VramFront + VramStep;

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
    // ClearScreen();

    PrintS(Status + 1 * VramStep, "SCORE");
    PrintS(Status + 7 * VramStep, "HI-SCORE");
    PrintS(Status + 16 * VramStep, "ST");
    PrintByteNumber2(Status + VramRowSize + 16 * VramStep, CurrentStage + 1);
    PrintS(Status + 19 * VramStep, "TIME");

    if (RemainSolverCount > 1) {
        Put2C(Status + 24 * VramStep, Char_Solver);
        PrintC(Status + VramRowSize + 26 * VramStep, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2(Status + 24 * VramStep);
        Put(Status + VramRowSize + 26 * VramStep, Char_Space);
    }

    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Status + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Status + VramRowSize + 9 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Status + VramRowSize + 20 * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Status + 28 * VramStep, pattern);
    }
    else {
        Erase2(Status + 28 * VramStep);
    }
}


void PrintGameOver()
{
    PrintS(VramBack + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramBack + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}


struct Text {
    ptr<byte> pVram;
    ptr<byte> string;
};

void Title()
{
    ptr<Text> pText;
    HScroll = 0;
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        byte c = Char_Title;
        ptr<byte> pVram = VramBack + VramRowSize * 4 + 10 * VramStep;
        repeat(6) {
            pVram = Put2C(pVram, c);
            c += 4;
        }
    
        Put2C(VramBack + VramRowSize * 9 + 9 * VramStep, Char_Solver);
        Put2C(VramBack + VramRowSize * 12 + 9 * VramStep, Char_Monster);
        Put2C(VramBack + VramRowSize * 15 + 9 * VramStep, Char_Card);

        PrintS(VramBack + VramRowSize * 7 + 7 * VramStep, "--- CHARACTER ---");
        PrintS(VramBack + VramRowSize * 10 + 12 * VramStep, "SOLVER");
        PrintS(VramBack + VramRowSize * 13 + 12 * VramStep, "MONSTER");
        PrintS(VramBack + VramRowSize * 16 + 12 * VramStep, "CARD");

        PrintS(VramBack + VramRowSize * 21 + 7 * VramStep, "PUSH START BUTTON");
        PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2025");
        }
    // {
    //     ptr<byte> pVram = VramBack + VramRowSize * 2;
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