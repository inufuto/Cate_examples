#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Knife.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

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
    PrintS(Vram + AsciiRowHeight * 0 + VVramWidth * VramStep, "SCORE"); 
    PrintS(Vram + AsciiRowHeight * 3 + VVramWidth * VramStep, "HI-SCORE");
    PrintS(Vram + AsciiRowHeight * 6 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight * 6 + (VVramWidth + 6) * VramStep, CurrentStage + 1);
    PrintS(Vram + AsciiRowHeight * 8 + VVramWidth * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 24 + (VVramWidth + 1) * VramStep;
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
    
    vram = PrintNumber5(Vram + AsciiRowHeight * 1 + (VVramWidth + 2) * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + AsciiRowHeight * 4 + (VVramWidth + 2) * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + AsciiRowHeight * 8 + (VVramWidth + 5) * VramStep, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    byte count, i;

    vram = Vram + VramRowSize * 22 + (VVramWidth + 1) * VramStep;
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
    PrintS(Vram + VramRowSize * 11 + (VVramWidth - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + (VVramWidth - 7) / 2 * VramStep, "TIME UP");
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
    PrintS(Vram + VramRowSize * 6 + 9 * VramStep, "MAN");
    PrintS(Vram + VramRowSize * 8 + 9 * VramStep, "CHASER");
    PrintS(Vram + VramRowSize * 10 + 9 * VramStep, "DISTURBER");
    PrintS(Vram + VramRowSize * 12 + 9 * VramStep, "EXIT");

    PrintS(Vram + AsciiRowHeight * 13 + (VVramWidth - 7) * VramStep / 2, "S:START");
    PrintS(Vram + AsciiRowHeight * 14 + (VVramWidth - 7) * VramStep / 2, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 16 + (VVramWidth - 12) * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - CharWidth * 16;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}
