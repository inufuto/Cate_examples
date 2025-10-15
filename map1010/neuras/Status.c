#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Backgnd.h"

ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
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
    PrintS(Vram + 1, "SCORE");  
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE"); 
    PrintByteNumber2(Vram + VramRowSize + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    if (RemainSolverCount > 1) {
        Print2x2(Vram + 27, Pattern_Solver_Left);
        PrintC(Vram + VramRowSize + 29, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2x2(Vram + 27);
        PrintC(Vram + VramRowSize + 29, ' ');
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize + 23, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Pattern_Card + (pHeldCard->status & 0xf);
        Print2x2(Vram + 30, pattern);
    }
    else {
        Erase2x2(Vram + 30);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 11 + 10;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    // HideAllSprites();

    {
        ptr<byte> pVram;
        byte pattern;
        
        pattern = Pattern_Title;
        pVram = Vram + VramRowSize * 4 + 10;
        repeat(6) {
            Print2x2(pVram, pattern);
            ++pattern;
            pVram += 2;
        }
    }

    Print2x2(Vram + VramRowSize * 9 + 9, Pattern_Solver_Left);
    Print2x2(Vram + VramRowSize * 12 + 9, Pattern_Monster_Left);
    Print2x2(Vram + VramRowSize * 15 + 9, Pattern_Card);

    PrintStatus();
    PrintS(Vram + VramRowSize * 7 + 7, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 10 + 12, "SOLVER");
    PrintS(Vram + VramRowSize * 13 + 12, "MONSTER");
    PrintS(Vram + VramRowSize * 16 + 12, "CARD");
    PrintS(Vram + VramRowSize * 21 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 22 + 9, "OR SHIFT KEY");
}
