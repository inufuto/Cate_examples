#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

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
    // ClearScreen();

    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");

    if (RemainSolverCount > 1) {
        Put2C(Vram + 27 * VramStep, Char_Solver);
        PrintC(Vram + AsciiRowHeight + 29 * VramStep, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2(Vram + 27 * VramStep);
        PrintC(Vram + AsciiRowHeight + 29 * VramStep, ' ');
    }

    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + AsciiRowHeight, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + AsciiRowHeight + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + AsciiRowHeight + 23 * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + 30 * VramStep, pattern);
    }
    else {
        Erase2(Vram + 30 * VramStep);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
    DrawAll();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    {
        byte c = Char_Title;
        word vram = Vram + VramRowSize * 4 + 10 * VramStep;
        repeat(6) {
            Put2C(vram, c);
            c += 4;
            vram += 2 * VramStep;
        }

        Put2C(Vram + VramRowSize * 9 + 9 * VramStep, Char_Solver);
        Put2C(Vram + VramRowSize * 12 + 9 * VramStep, Char_Monster);
        Put2C(Vram + VramRowSize * 15 + 9 * VramStep, Char_Card);
    }
    PrintStatus();
    PrintS(Vram + VramRowSize * 7 + 7 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 10 + 12 * VramStep, "SOLVER");
    PrintS(Vram + VramRowSize * 13 + 12 * VramStep, "MONSTER");
    PrintS(Vram + VramRowSize * 16 + 12 * VramStep, "CARD");
    PrintS(Vram + AsciiRowHeight * 14 + 11 * VramStep, "S:START");
    PrintS(Vram + AsciiRowHeight * 15 + 11 * VramStep, "C:CONTINUE");
    // {
    //     word vram = Vram + VramWidth * CharHeight * 8;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramWidth * CharHeight - CharWidth * 16;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}