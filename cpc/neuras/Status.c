#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Backgnd.h"

constexpr byte Status_X = 32*2;

static word PrintS(word vramAddress, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vramAddress = PrintC(vramAddress, c);
        ++p;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize + Status_X, "SCORE");
    PrintS(Vram + VramRowSize * 4 + Status_X, "HIGH");
    PrintS(Vram + VramRowSize * 5 + Status_X, "SCORE");
    PrintS(Vram + VramRowSize * 8 + Status_X, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + Status_X + 3*2, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 11 + Status_X, "TIME");

    {
        word vramAddress;
        byte count;
        vramAddress = Vram + VramRowSize * 21 + Status_X;

        for (count = 1; count < RemainSolverCount; ++count) {
            Print2x2(vramAddress, Pattern_Solver_Left);
            vramAddress += 2*2;
        }
        for (; count < 3; ++count) {
            Erase2x2(vramAddress);
            vramAddress += 2*2;
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word vramAddress;
    
    vramAddress = PrintNumber5(Vram + VramRowSize * 2 + Status_X, Score);
    PrintC(vramAddress, '0');

    vramAddress = PrintNumber5(Vram + VramRowSize * 6 + Status_X, HiScore);
    PrintC(vramAddress, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + Status_X + 1*2, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Pattern_Card + (pHeldCard->status & 0xf);
        Print2x2(Vram + VramRowSize * 18 + Status_X, pattern);
    }
    else {
        Erase2x2(Vram + VramRowSize * 18 + Status_X);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram + VramWidth * 11 + 10;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen();
    {
        ptr<byte> pByte;
        word count;

        pByte = Backgnd;
        count = StageWidth * StageHeight;
        do {
            *pByte = Char_Space;
            ++pByte;
            --count;
        } while (count !=0);
    } 
    {
        byte pattern;
        word vramAddress;
        
        pattern = Pattern_Title;
        vramAddress = Vram + VramRowSize * 2 + 10*2;
        repeat(6) {
            Print2x2(vramAddress, pattern);
            ++pattern;
            vramAddress += 2*2;
        }
    }
    Print2x2(Vram + VramRowSize * 8 + 9*2, Pattern_Solver_Left);
    Print2x2(Vram + VramRowSize * 11 + 9*2, Pattern_Monster_Left);
    Print2x2(Vram + VramRowSize * 14 + 9*2, Pattern_Card);

    PrintStatus();
    PrintS(Vram + VramRowSize * 6 + 7*2, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 9 + 13*2, "SOLVER");
    PrintS(Vram + VramRowSize * 12 + 13*2, "MONSTER");
    PrintS(Vram + VramRowSize * 15 + 13*2, "CARD");
    PrintS(Vram + VramRowSize * 21 + 9*2, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 22 + 9*2, "OR SHIFT KEY");
}