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
    PrintS(Vram + VramRowSize * 0 + WindowWidth * VramStep, "SCORE"); 
    PrintS(Vram + VramRowSize * 4 + WindowWidth * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + WindowWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + (WindowWidth + 6) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + WindowWidth * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 22 + (WindowWidth + 1) * VramStep;
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
    
    vram = PrintNumber5(Vram + VramRowSize * 1 + (WindowWidth + 2) * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 5 + (WindowWidth + 2) * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + (WindowWidth + 5) * VramStep, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    byte count, i;

    vram = Vram + VramRowSize * 20 + (WindowWidth + 1) * VramStep;
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
    PrintS(Vram + VramRowSize * 11 + (WindowWidth - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + (WindowWidth - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    {
        word vram;
        byte c;
        vram = Vram + VramRowSize * 0 + 12 * VramStep;
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
    Put2C(Vram + VramRowSize * 6 + 9 * VramStep, Char_Man);
    Put2C(Vram + VramRowSize * 8 + 9 * VramStep, Char_Chaser);
    Put2C(Vram + VramRowSize * 10 + 9 * VramStep, Char_Disturber);
    Put2C(Vram + VramRowSize * 12 + 9 * VramStep, Char_Goal);
    
    PrintStatus(); 
    PrintS(Vram + VramRowSize * 3 + 8 * VramStep, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 6 + 14 * VramStep, "MAN");
    PrintS(Vram + VramRowSize * 8 + 14 * VramStep, "CHASER");
    PrintS(Vram + VramRowSize * 10 + 14 * VramStep, "DISTURBER");
    PrintS(Vram + VramRowSize * 12 + 14 * VramStep, "EXIT");

    PrintS(Vram + VramRowSize * 20 + (WindowWidth - 14) / 2 * VramStep, "PUSH SPACE KEY");
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
