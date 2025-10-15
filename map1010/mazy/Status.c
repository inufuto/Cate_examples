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
    PrintS(Vram + VramRowSize * 0 + 24, "SCORE"); 
    PrintS(Vram + VramRowSize * 5 + 24, "HI-SCORE");
    PrintS(Vram + VramRowSize * 10 + 24, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 10 + 30, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 13 + 24, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 19 + 25;
        ptr<byte> pVram;
        byte count;
        pVram = RemainLeft;
        for (count = 1; count < RemainCount; ++count) {
            pVram = Put2(pVram, Char_Man);
        }
    }

    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 26, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 7 + 26, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 13 + 29, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    byte count, i;

    pVram = Vram + VramRowSize * 17 + 25;
    i = 0;
    count = HeldKnifeCount;
    while (count != 0) {
        pVram = Put(pVram, Char_Kn_Left);
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
        ptr<byte> pVram;
        byte c;
        pVram = Vram + VramRowSize * 0 + 8;
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
    Put2(Vram + VramRowSize * 6 + 5, Char_Man);
    Put2(Vram + VramRowSize * 8 + 5, Char_Chaser);
    Put2(Vram + VramRowSize * 10 + 5, Char_Disturber);
    Put2(Vram + VramRowSize * 12 + 5, Char_Goal);
    
    PrintStatus(); 
    PrintS(Vram + VramRowSize * 3 + 4, "--- CHARACTER ---");
    PrintS(Vram + VramRowSize * 6 + 10, "MAN");
    PrintS(Vram + VramRowSize * 8 + 10, "CHASER");
    PrintS(Vram + VramRowSize * 10 + 10, "DISTURBER");
    PrintS(Vram + VramRowSize * 12 + 10, "EXIT");

    PrintS(Vram + VramRowSize * 17 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 19 + 5, "OR SHIFT KEY");
}
