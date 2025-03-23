#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Knife.h"

constexpr byte StatusLeft = 1 + VVramWidth;

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
    PrintS(VramFront + VramRowSize * 0 + StatusLeft * VramStep, "SCORE"); 
    PrintS(VramFront + VramRowSize * 3 + StatusLeft * VramStep, "HIGH");
    PrintS(VramFront + VramRowSize * 4 + StatusLeft * VramStep, "SCORE"); 
    PrintS(VramFront + VramRowSize * 7 + StatusLeft * VramStep, "STAGE");
    PrintByteNumber2(VramFront + VramRowSize * 8 + (StatusLeft + 4) * VramStep, CurrentStage + 1);
    PrintS(VramFront + VramRowSize * 10 + StatusLeft * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = VramFront + VramRowSize * 22 + (StatusLeft + 1) * VramStep;
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
    
    pVram = PrintNumber5(VramFront + VramRowSize * 1 + StatusLeft * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(VramFront + VramRowSize * 5 + StatusLeft * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(VramFront + VramRowSize * 11 + (StatusLeft + 3) * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    byte count, i;

    pVram = VramFront + VramRowSize * 20 + (StatusLeft + 1) * VramStep;
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
    PrintS(VramBack + VramRowSize * 11 + (1 + (VVramWidth - 9) / 2) * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramBack + VramRowSize * 11 + (1 + (VVramWidth - 7) / 2) * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    {
        ptr<byte> pVram;
        byte c;
        pVram = VramBack + VramRowSize * 0 + 9 * VramStep;
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
    Put2C(VramBack + VramRowSize * 6 + 8 * VramStep, Char_Man);
    Put2C(VramBack + VramRowSize * 8 + 8 * VramStep, Char_Chaser);
    Put2C(VramBack + VramRowSize * 10 + 8 * VramStep, Char_Disturber);
    Put2C(VramBack + VramRowSize * 12 + 8 * VramStep, Char_Goal);
    
    PrintStatus(); 
    PrintS(VramBack + VramRowSize * 3 + 5 * VramStep, "--- CHARACTER ---");
    PrintS(VramBack + VramRowSize * 6 + 11 * VramStep, "MAN");
    PrintS(VramBack + VramRowSize * 8 + 11 * VramStep, "CHASER");
    PrintS(VramBack + VramRowSize * 10 + 11 * VramStep, "DISTURBER");
    PrintS(VramBack + VramRowSize * 12 + 11 * VramStep, "EXIT");

    PrintS(VramBack + VramRowSize * 20 + 5 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 13 * VramStep, "INUFUTO 2025");
    // {
    //     byte c;
    //     ptr<byte> v;
    //     v = Vram+VramRowSize*8;
    //     c = 0;
    //     repeat (16) {
    //         repeat (16) {
    //             v = Put(v, c);
    //             ++c;
    //         }
    //         v += VramRowSize - 16 * VramStep;
    //     }
    // }
}
