#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"

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

    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + Vram_Width + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    if (RemainSolverCount > 1) {
        VPut2(27, 0, Char_Solver);
        PrintC(Vram + Vram_Width + 29, RemainSolverCount - 1 + '0');
    }
    else {
        VErase2(27, 0);
        PrintC(Vram + Vram_Width + 29, ' ');
    }

    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + Vram_Width, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + Vram_Width + 9, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + Vram_Width + 23, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        VPut2(30, 0, pattern);
    }
    else {
        VErase2(30, 0);
    }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word address;

    address = Vram + Vram_Width * 11 + 10;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += Vram_Width - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + Vram_Width * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + Vram_Width * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    {
        byte x, c;
        
        c = Char_Title;
        x = 10;
        repeat(6) {
            VPut2(x, 4, c);
            c += 4;
            x += 2;
        }

        VPut2(9, 9, Char_Solver);
        VPut2(9, 12, Char_Monster);
        VPut2(9, 15, Char_Card);
    }
    PrintStatus();
    PrintS(Vram + Vram_Width * 7 + 7, "--- CHARACTER ---");
    PrintS(Vram + Vram_Width * 10 + 12, "SOLVER");
    PrintS(Vram + Vram_Width * 13 + 12, "MONSTER");
    PrintS(Vram + Vram_Width * 16 + 12, "CARD");
    PrintS(Vram + Vram_Width * 21 + 9, "PUSH SPACE KEY");
    PrintS(Vram + Vram_Width * 22 + 9, "OR GRPH KEY");
}