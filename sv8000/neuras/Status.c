#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Stage.h"
#include "Card.h"

constexpr byte Char_Remain = Char_Solver;

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
    PrintS(Vram + 0, "SC");
    PrintS(Vram + 9, "HI");
    PrintS(Vram + 18, "ST");
    PrintByteNumber2(Vram + 20, CurrentStage + 1);
    PrintS(Vram+ 23, "T");
    {
        word vram;
        vram = Vram + 29;
        if (RemainSolverCount > 1) {
            byte i;
            vram = Put2C(vram, Char_Remain);
            if (RemainSolverCount > 2) {
                vram = PrintC(Vram + 31, RemainSolverCount + '0' - 1);
            }
        }
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + 2 , Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + 11, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    word vram = PrintByteNumber3(Vram + 24, StageTime);
    if (StageTime < 100) {
        PrintC(vram, ' ');
    }
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + 27, pattern);
    }
    else {
        Erase2(Vram + 27);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    // HideAllSprites();
    PrintStatus();
    {
        byte c;
        word vram;
        vram = Vram + VramRowSize * 3 + 9;
        c = Char_Title;
        repeat(6) {
            vram = Put2C(vram, c);
            c += 4;
        }
    }
    PrintS(Vram + VramRowSize * 6 + 7, "--- CHARACTER ---");
    Put2C(Vram + VramRowSize * 9 + 10, Char_Solver_Left);
    Put2C(Vram + VramRowSize * 11 + 10, Char_Monster_Left);
    Put2C(Vram + VramRowSize * 13 + 10, Char_Card);
    PrintS(Vram + VramRowSize * 9 + 13, "SOLVER");
    PrintS(Vram + VramRowSize * 11 + 13, "MONSTER");
    PrintS(Vram + VramRowSize * 13 + 13, "CARD");
    PrintS(Vram + VramRowSize * 18 + 12, "0:START");
    PrintS(Vram + VramRowSize * 20 + 12, "1:CONTINUE");
    // {
    //     byte c;
    //     ptr<byte> v;
    //     v = Vram+32*10;
    //     c = Char_Title-32+24;
    //     repeat (32) {
    //         v = Put(v, c);
    //         ++c;
    //     }
    // }
}
