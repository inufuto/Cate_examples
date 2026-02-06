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
    PrintS(Vram + VramRowSize * 0 + 24, "SCORE"); 
    PrintS(Vram + VramRowSize * 4 + 24, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 24, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 30, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 24, "TIME");
    {
        constexpr word RemainLeft = Vram + VramRowSize * 22 + 25;
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
    
    vram = PrintNumber5(Vram + VramRowSize * 1 + 26, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 5 + 26, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + 29, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    byte count, i;

    vram = Vram + VramRowSize * 20 + 25;
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
    PrintS(Vram + VramRowSize * 11 + 12, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 13, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    {
        word vram;
        byte c;
        vram = Vram + VramRowSize * 0 + 8;
        c = Char_Title;
        repeat (4) {
            repeat (2) {
                repeat (2) {
                    vram = Put(vram, c);
                    ++c;
                }
                vram += VramRowSize - 2 * VramStep;
            }
            c += 4;
            vram += 2 * VramStep - VramRowSize * 2;
        }
    }
    Put2C(Vram + VramRowSize * 6 + 5, Char_Man);
    Put2C(Vram + VramRowSize * 8 + 5, Char_Chaser);
    Put2C(Vram + VramRowSize * 10 + 5, Char_Disturber);
    Put2C(Vram + VramRowSize * 12 + 5, Char_Goal);
    
    PrintStatus(); 
    PrintS(Vram + VramRowSize * 3 + 4, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 6 + 10, "MAN");
    PrintS(Vram + VramRowSize * 8 + 10, "CHASER");
    PrintS(Vram + VramRowSize * 10 + 10, "DISTURBER");
    PrintS(Vram + VramRowSize * 12 + 10, "EXIT");

    PrintS(Vram + VramRowSize * 20 + 3, "PUSH TRIGGER BUTTON");
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
