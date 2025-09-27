#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

constexpr word VramTop = Vram + VramRowSize;
constexpr byte Status_X = 32 * VramStep;

static word PrintS(word vram, ptr<byte> p)
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
    PrintS(Vram + VramRowSize + Status_X, "SCORE");
    PrintS(Vram + VramRowSize * 4 + Status_X, "HIGH");
    PrintS(Vram + VramRowSize * 5 + Status_X, "SCORE");
    PrintS(Vram + VramRowSize * 8 + Status_X, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + Status_X + 3 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 11 + Status_X, "TIME");

    {
        word vram;
        byte count;
        vram = Vram + VramRowSize * 20 + Status_X;

        for (count = 1; count < RemainSolverCount; ++count) {
            Put2C(vram, Char_Solver);
            vram += 2 * VramStep;
        }
        for (; count < 3; ++count) {
            Erase2(vram);
            vram += 2 * VramStep;
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + Status_X, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + Status_X, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + Status_X + 1 * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + VramRowSize * 18 + Status_X, pattern);
    }
    else {
        Erase2(Vram + VramRowSize * 18 + Status_X);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 4;    
    word vram;

    vram = VramTop + VramRowSize * 9 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            Put(vram, Char_Space);
            vram += VramStep;
        }
        vram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen();
    HideAllSprites();
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
        word vram;
        
        c = Char_N;
        vram = Vram + VramRowSize * 2 + 10 * VramStep;
        repeat(6) {
            Put2C(vram, c);
            c += 4;
            vram += 2 * VramStep;
        }
    } 
    Put2C(Vram + VramRowSize * 8 + 9 * VramStep, Char_Solver);
    Put2C(Vram + VramRowSize * 11 + 9 * VramStep, Char_Monster);
    Put2C(Vram + VramRowSize * 14 + 9 * VramStep, Char_Card);

    PrintStatus();
    PrintS(Vram + VramRowSize * 6 + 7 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 9 + 13 * VramStep, "SOLVER");
    PrintS(Vram + VramRowSize * 12 + 13 * VramStep, "MONSTER");
    PrintS(Vram + VramRowSize * 15 + 13 * VramStep, "CARD");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR SHIFT KEY");
}