#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"
#include "Main.h"
#include "Stage.h"
#include "Card.h"

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
    PrintS(Vram + 0, "SCORE");
    PrintS(Vram + 14, "HI-SCORE");
    PrintS(Vram + 32, "STAGE");
    PrintByteNumber2(Vram + VramWidth + 38, CurrentStage + 1);
    PrintS(Vram + 43, "TIME");
    {
        word vram;
        vram = Vram + 58;
        if (RemainSolverCount > 1) {
            byte i;
            i = RemainSolverCount - 1;
            if (i > 2) {
                vram = Put(vram, Char_Remain);
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram -= 2;
                vram = PrintC(vram, i + '0');
            }
            else {
                do {
                    vram = Put(vram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
        vram = Put(vram, Char_Space);
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    word vram = PrintNumber5(Vram + 6, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + 23, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    word vram = PrintByteNumber3(Vram + 48, StageTime);
    PrintC(vram, ' ');
}

void PrintHeldCard() 
{
    byte pattern;
    if (pHeldCard != nullptr) {
        pattern = Char_MiniCard + (pHeldCard->status & 0xf) - 1;
    }
    else {
        pattern = Char_Space;
    }
    Put(Vram + 53, pattern);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 27, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 28, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
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
    Put2C(Vram + VramRowSize * 8 + 12 * VramStep, Char_Solver);
    Put2C(Vram + VramRowSize * 11 + 12 * VramStep, Char_Monster);
    Put2C(Vram + VramRowSize * 14 + 12 * VramStep, Char_ClosedCard);

    PrintS(Vram + VramRowSize * 6 + 24, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 9 + 16 * VramStep, "SOLVER");
    PrintS(Vram + VramRowSize * 12 + 16 * VramStep, "MONSTER");
    PrintS(Vram + VramRowSize * 15 + 16 * VramStep, "CARD");
    PrintS(Vram + VramRowSize * 21 + 25, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 22 + 25, "OR GRPH KEY");
}
