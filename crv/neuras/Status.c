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

    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    if (RemainSolverCount > 1) {
        Put2CXY(27, 0, Char_Solver);
        PrintC(Vram + VramRowSize + 29, RemainSolverCount - 1 + '0');
    }
    else {
        Erase2XY(27, 0);
        PrintC(Vram + VramRowSize + 29, ' ');
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

    address = PrintNumber5(Vram + VramRowSize + 9, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize + 23, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2CXY(30, 0, pattern);
    }
    else {
        Erase2XY(30, 0);
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


struct Text {
    word vram;
    ptr<byte> string;
};

static const Text[] Texts = {
    { Vram + VramRowSize * 7 + 7, "--- CHARACTER ---" },
    { Vram + VramRowSize * 10 + 12, "SOLVER" },
    { Vram + VramRowSize * 13 + 12, "MONSTER" },
    { Vram + VramRowSize * 16 + 12, "CARD" },
    { Vram + VramRowSize * 22 + 7, "PUSH TRIGGER BUTTON" },
 } ;

void Title()
{
    ptr<Text> pText;
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    {
        byte x, c;
        
        c = Char_Title;
        x = 10;
        repeat(6) {
            Put2CXY(x, 4, c);
            c += 4 + 4;
            x += 2;
        }

        Put2CXY(9, 9, Char_Solver);
        Put2CXY(9, 12, Char_Monster);
        Put2CXY(9, 15, Char_Card);
    }
    PrintStatus();
    for (pText: Texts) {
        PrintS(pText->vram, pText->string);    
    }
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