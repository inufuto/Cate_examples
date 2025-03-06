#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(Vram + 1, "SCORE");  
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE"); 
    PrintByteNumber2(Vram + VramRowSize + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    if (RemainSolverCount > 1) {
        Put2C(Vram + 27, Char_Solver);
        PrintC(Vram + VramRowSize + 29, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2(Vram + 27);
        PrintC(Vram + VramRowSize + 29, ' ');
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize + 9, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize + 23, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + 30, pattern);
    }
    else {
        Erase2(Vram + 30);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramRowSize * 11 + 10;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramRowSize - width;
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
        byte c = Char_Title;
        word vram = Vram + VramRowSize * 4 + 10;
        repeat(6) {
            vram = Put2C(vram, c);
            c += 4;
        }
    }

    Put2C(Vram + VramRowSize * 9 + 9, Char_Solver);
    Put2C(Vram + VramRowSize * 12 + 9, Char_Monster);
    Put2C(Vram + VramRowSize * 15 + 9, Char_Card);

    PrintStatus();
    PrintS(Vram + VramRowSize * 7 + 7, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 10 + 12, "SOLVER");
    PrintS(Vram + VramRowSize * 13 + 12, "MONSTER");
    PrintS(Vram + VramRowSize * 16 + 12, "CARD");
    PrintS(Vram + VramRowSize * 21 + 7 * VramStep, "PUSH TRIGGER BUTTON");
}
