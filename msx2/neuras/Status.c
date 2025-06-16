#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

void PrintStatus() 
{
    // ClearScreen();

    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");

    if (RemainSolverCount > 1) {
        Put2C(Vram + 27 * VramStep, Char_Solver);
        PrintC(Vram + VramRowSize + 29 * VramStep, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2(Vram + 27 * VramStep);
        PrintC(Vram + VramRowSize + 29 * VramStep, ' ');
    }

    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
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

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word address;

    address = Vram + VramRowSize * 11 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += VramRowSize - width * VramStep;
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
    {
        byte c;
        word vram;
        c = Char_Title;
        vram = Vram + VramRowSize * 4 + 10 * VramStep;
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
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 22 + 9 * VramStep, "OR GRPH KEY");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}