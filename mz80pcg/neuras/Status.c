#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Card.h"
#include "Chars.h"
#include "Print.h"

extern const byte[] CardChars;
constexpr byte Status_X = 32;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
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
        ptr<byte> pVram;
        byte count;
        pVram = Vram + VramWidth * 21 + Status_X;

        for (count = 1; count < RemainSolverCount; ++count) {
            Put2C(pVram, Char_Solver_Left);
            pVram += 2;
        }
        for (; count < 3; ++count) {
            Erase2(pVram);
            pVram += 3;
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramWidth * 2 + Status_X, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramWidth * 6 + Status_X, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramWidth * 12 + Status_X + 1, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        ptr<byte> p = CardChars + ((pHeldCard->status & 0xf) << 2);
        Put2S(Vram + VramRowSize * 18 + Status_X * VramStep, p);
    }
    else {
        Erase2(Vram + VramWidth * 18 + Status_X);
    }
}

void PrintGameOver()
{
    VVramToVram();
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    VVramToVram();
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen();
    {
        static const byte[] TitleBytes = {
            //	N
            0x3b, 0x85, 0x00, 0x43, 
            0x3b, 0x43, 0x85, 0x43, 
            0x3b, 0x7b, 0x86, 0x43, 
            0x82, 0x80, 0x00, 0x7a, 
            //	E
            0x3b, 0x83, 0x7a, 0x80, 
            0x3b, 0x85, 0x3a, 0x81, 
            0x3b, 0x7b, 0x00, 0x00, 
            0x82, 0x7a, 0x7a, 0x80, 
            //	U
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x00, 0x7a, 0x7a, 0x80, 
            //	R
            0x3b, 0x83, 0x7a, 0x85, 
            0x3b, 0x7b, 0x84, 0x43, 
            0x3b, 0x83, 0x43, 0x81, 
            0x82, 0x80, 0x82, 0x7a, 
            //	A
            0x00, 0x87, 0x86, 0x81, 
            0x3b, 0x7b, 0x00, 0x43, 
            0x3b, 0x83, 0x7a, 0x43, 
            0x82, 0x80, 0x00, 0x7a, 
            //	S
            0x84, 0x83, 0x7a, 0x85, 
            0x82, 0x85, 0x3a, 0x81, 
            0x84, 0x81, 0x00, 0x43, 
            0x00, 0x7a, 0x7a, 0x80, 
        };
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 1 + 4;        
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    *pVram = *p; ++pVram;
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
    }
    Put2C(Vram + VramWidth * 8 + 9, Char_Solver_Left);
    Put2C(Vram + VramWidth * 11 + 9, Char_Monster_Left);
    Put2C(Vram + VramWidth * 14 + 9, Char_Card);

    PrintStatus();
    PrintS(Vram + VramWidth * 6 + 7, "--- CHARACTER ---");
    PrintS(Vram + VramWidth * 9 + 13, "SOLVER");
    PrintS(Vram + VramWidth * 12 + 13, "MONSTER");
    PrintS(Vram + VramWidth * 15 + 13, "CARD");
    PrintS(Vram + VramWidth * 21 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 22 + 9, "OR CR KEY");
}