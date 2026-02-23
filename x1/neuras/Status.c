#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Backgnd.h"

constexpr byte Status_X = 32;

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramWidth + Status_X, "SCORE");
    PrintS(Vram + VramWidth * 4 + Status_X, "HIGH");
    PrintS(Vram + VramWidth * 5 + Status_X, "SCORE");
    PrintS(Vram + VramWidth * 8 + Status_X, "STAGE");
    PrintByteNumber2(Vram + VramWidth * 9 + Status_X + 3, CurrentStage + 1);
    PrintS(Vram + VramWidth * 11 + Status_X, "TIME");

    {
        word address;
        byte count;
        address = Vram + VramWidth * 21 + Status_X;

        for (count = 1; count < RemainSolverCount; ++count) {
            Print2x2(address, Pattern_Solver_Left);
            address += 2;
        }
        for (; count < 3; ++count) {
            Erase2x2(address);
            address += 2;
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + VramWidth * 2 + Status_X, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramWidth * 6 + Status_X, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramWidth * 12 + Status_X + 1, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Pattern_Card + (pHeldCard->status & 0xf);
        Print2x2(Vram + VramWidth * 18 + Status_X, pattern);
    }
    else {
        Erase2x2(Vram + VramWidth * 18 + Status_X);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 4;    
    ptr<byte> pByte;

    pByte = VVram + StageWidth * 9 + 10;
    repeat (height) {
        repeat (width) {
            *pByte = Char_Space;
            ++pByte;
        }
        pByte += StageWidth - width;
    }
    RowFlags[1] = 0xff;
}

void PrintGameOver()
{
    EraseWindow();
    VVramToVram();
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    VVramToVram();
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
        word address;
        
        pattern = Pattern_Title;
        address = Vram + VramWidth * 2 + 10;
        repeat(6) {
            Print2x2(address, pattern);
            ++pattern;
            address += 2;
        }
    }
    Print2x2(Vram + VramWidth * 8 + 9, Pattern_Solver_Left);
    Print2x2(Vram + VramWidth * 11 + 9, Pattern_Monster_Left);
    Print2x2(Vram + VramWidth * 14 + 9, Pattern_Card);

    PrintStatus();
    PrintS(Vram + VramWidth * 6 + 7, "--- CHARACTER ---");
    PrintS(Vram + VramWidth * 9 + 13, "SOLVER");
    PrintS(Vram + VramWidth * 12 + 13, "MONSTER");
    PrintS(Vram + VramWidth * 15 + 13, "CARD");
    PrintS(Vram + VramWidth * 21 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 22 + 9, "OR RETURN KEY");
}