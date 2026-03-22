#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Knife.h"

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 0 + 24 * VramStep, "SCORE"); 
    PrintS(Vram + VramRowSize * 4 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 30 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 24 * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 22 + 25 * VramStep;
        ptr<byte> pVram;
        byte count;
        pVram = RemainLeft;
        for (count = 1; count < RemainCount; ++count) {
            pVram = Put2C(pVram, Char_Man);
        }
    }

    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 1 + 26 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 5 + 26 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + 29 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    byte count, i;

    pVram = Vram + VramRowSize * 20 + 25 * VramStep;
    i = 0;
    count = HeldKnifeCount;
    while (count != 0) {
        pVram = Put(pVram, Char_Knife_Left);
        ++i;
        --count;
    }
    while (i != 4) {
        pVram = Put(pVram, Char_Space);
        ++i;
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    {
        ptr<byte> pVram;
        byte c;
        pVram = Vram + VramRowSize * 0 + 8 * VramStep;
        c = Char_Title;
        repeat (4) {
            repeat (2) {
                repeat (2) {
                    pVram = Put(pVram, c);
                    ++c;
                }
                pVram += VramRowSize - 2 * VramStep;
            }
            pVram += 2 * VramStep - VramRowSize * 2;
        }
    }
    Put2C(Vram + VramRowSize * 6 + 5 * VramStep, Char_Man);
    Put2C(Vram + VramRowSize * 8 + 5 * VramStep, Char_Chaser);
    Put2C(Vram + VramRowSize * 10 + 5 * VramStep, Char_Disturber);
    Put2C(Vram + VramRowSize * 12 + 5 * VramStep, Char_Goal);
    
    PrintStatus(); 
    PrintS(Vram + VramRowSize * 3 + 4 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 6 + 10 * VramStep, "MAN");
    PrintS(Vram + VramRowSize * 8 + 10 * VramStep, "CHASER");
    PrintS(Vram + VramRowSize * 10 + 10 * VramStep, "DISTURBER");
    PrintS(Vram + VramRowSize * 12 + 10 * VramStep, "EXIT");

    PrintS(Vram + VramRowSize * 19 + 8 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 20 + 8 * VramStep, "X:CONTINUE");
    // {
    //     byte c;
    //     word v;
    //     v = Vram+32*6;
    //     c = 0;
    //     repeat (0) {
    //         v = Put(v, c);
    //         ++c;
    //     }
    // }
}
