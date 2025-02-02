#include "Status.h"
#include "Vram.h"
#include "VVram.h"
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
    PrintS(Vram + VramRowSize * 0 + VVramWidth * VramStep, "SCORE"); 
    PrintS(Vram + VramRowSize * 4 + VVramWidth * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + (VVramWidth + 6) * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + VVramWidth * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 22 + (VVramWidth + 1) * VramStep;
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
    
    pVram = PrintNumber5(Vram + VramRowSize * 1 + (VVramWidth + 2) * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 5 + (VVramWidth + 2) * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 12 + (VVramWidth + 5) * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    byte count, i;

    pVram = Vram + VramRowSize * 20 + (VVramWidth + 1) * VramStep;
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

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;
    byte y;

    pVram = Vram + VramRowSize * 10 + (VVramWidth - width) / 2 * VramStep;
    repeat (height) {
        repeat (width) {
            pVram = Put(pVram, Char_Space);
        }
        pVram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + (VVramWidth - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + (VVramWidth - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    {
        ptr<byte> pVram = Vram + VramRowSize * 0 + 12 * VramStep;
        byte c = Char_Title;
        repeat (4) {
            pVram = Put2C(pVram, c);
            c += 4;
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

    PrintS(Vram + VramRowSize * 20 + (VVramWidth - 14) / 2 * VramStep, "PUSH SPACE KEY");
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
