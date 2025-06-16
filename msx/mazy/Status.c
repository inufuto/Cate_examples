#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Knife.h"

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
    PrintS(Vram + VramRowSize * 0 + 24 * VramStep, "SCORE"); 
    PrintS(Vram + VramRowSize * 4 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 30 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 24 * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 22 + 25 * VramStep;
        word vram;
        byte count;
        vram = RemainLeft;
        for (count = 1; count < RemainCount; ++count) {
            vram = Put2C(vram, Char_Man);
        }
    }

    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 1 + 26 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 5 + 26 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + 29 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    byte count, i;

    vram = Vram + VramRowSize * 20 + 25 * VramStep;
    i = 0;
    count = HeldKnifeCount;
    while (count != 0) {
        vram = Put(vram, Char_Knife_Left);
        ++i;
        --count;
    }
    while (i != 4) {
        vram = Put(vram, Char_Space);
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
        word vram;
        byte c;
        vram = Vram + VramRowSize * 0 + 8 * VramStep;
        c = Char_Title;
        repeat (4) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            vram += 2 * VramStep - VramRowSize * 2;
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

    PrintS(Vram + VramRowSize * 17 + 5 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 18 + 5 * VramStep, "OR GRPH KEY");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
