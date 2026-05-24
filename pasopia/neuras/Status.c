#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

constexpr byte Status_X = 64;

word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
}


void PrintStatus() 
{
    PrintS(Vram + VramRowSize + Status_X, "SCORE");
    PrintS(Vram + VramRowSize * 6 + Status_X, "HI-SCORE");
    PrintS(Vram + VramRowSize * 11 + Status_X, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 11 + Status_X + 6*2, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 14 + Status_X, "TIME");

    {
        byte count;
        word vram = Vram + VramRowSize * 22 + Status_X;

        for (count = 1; count < RemainSolverCount; ++count) {
            vram = Put2C(vram, Char_Solver);
        }
        for (; count < 3; ++count) {
            vram = Erase2(vram);
        }
    }

    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + VramRowSize * 3 + Status_X + 2 * 2, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramRowSize * 8 + Status_X + 2 * 2, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 14 + Status_X + 2*5, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte c = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + VramRowSize * 19 + Status_X, c);
    }
    else {
        Erase2(Vram + VramRowSize * 19 + Status_X);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 4;    
    word address;

    address = Vram + VramRowSize * 10 + 20;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 22, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 24, "TIME UP");
}

void Title()
{
    ClearScreen();
    // WaitSync();
    {
        byte c = Char_Title;
        word vram = Vram + VramRowSize * 3 + 20;
        repeat(6) {
            vram = Put2C(vram, c);
            c += 4;
        }
    }

    Put2C(Vram + VramRowSize * 9 + 9*2, Char_Solver_Left);     
    Put2C(Vram + VramRowSize * 12 + 9*2, Char_Monster_Left);
    Put2C(Vram + VramRowSize * 15 + 9*2, Char_Card);   

    PrintStatus();
    PrintS(Vram + VramRowSize * 6 + 14, "--- CHARACTER ---"); 
    PrintS(Vram + VramRowSize * 9 + 26, "SOLVER");
    PrintS(Vram + VramRowSize * 12 + 26, "MONSTER");
    PrintS(Vram + VramRowSize * 15 + 26, "CARD");
    PrintS(Vram + VramRowSize * 19 + 18, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 18, "OR GRPH KEY");
}