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
    PrintS(Vram + 14 * VramStep, "SCORE");
    // PrintS(Vram + VramRowSize * 3 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 3 + 14 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 4 + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 6 + 14 * VramStep, "TIME");
    {
        constexpr ptr<byte> RemainLeft = Vram + VramRowSize * 16 + 15 * VramStep;
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
    vram = PrintNumber5(Vram + VramRowSize + 14 * VramStep, Score);
    PrintC(vram, '0');
    // vram = PrintNumber5(Vram + VramRowSize * 7 + 26, HiScore);
    // PrintC(vram, '0');
}

void PrintTime()
{
    PrintNumber3(Vram + VramRowSize * 7 + 17 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    word vram;
    byte count, i;

    vram = Vram + VramRowSize * 14 + 15 * VramStep;
    i = 0;
    count = HeldKnifeCount;
    while (count != 0) {
        vram = Put(vram, Char_Kn_Left);
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
    PrintS(Vram + VramRowSize * 8 + (14 - 9) / 2 * VramStep, "GAME OVER");
    // PresendVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 8 + (14 - 7) / 2 * VramStep, "TIME UP");
    // PresendVram();
}

void Title()
{
    ClearScreen(); 
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4f, 0x4d, 0x4d, 0x42, 
            0x48, 0x4f, 0x42, 0x44, 
            0x45, 0x4d, 0x43, 0x4f, 
            0x40, 0x4f, 
            0x4f, 0x4c, 0x4c, 0x43, 
            0x4f, 0x40, 0x4f, 0x40, 
            0x48, 0x47, 0x40, 0x4d, 
            0x4a, 0x47, 
            0x4f, 0x4c, 0x4c, 0x43, 
            0x4f, 0x45, 0x4f, 0x48, 
            0x47, 0x40, 0x40, 0x40, 
            0x4f, 0x40, 
            0x45, 0x44, 0x44, 0x41, 
            0x45, 0x40, 0x45, 0x44, 
            0x45, 0x45, 0x41, 0x40, 
            0x45, 0x40, 
        };
        constexpr byte LogoWidth = 14;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 4 + (14 - LogoWidth) / 2 * VramStep;
        p = TitleBytes;
        repeat (4) {
            repeat (LogoWidth) {
                vram = Put(vram, *p);
                ++p;
            }
            vram += VramRowSize - LogoWidth * VramStep;
        }
        PrintS(Vram + VramRowSize * 8 + ((14 + LogoWidth) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 14 + 0 * VramStep, "PUSH START");
    PrintS(Vram + VramRowSize * 15 + 8 * VramStep, "BUTTON");
    PrintS(Vram + VramRowSize * 17 + 2 * VramStep, "INUFUTO 2024");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (16) {
    //         repeat (16) {
    //             vram = Put(vram, c);
    //             ++c;
    //         }
    //         vram += VramRowSize - 16 * VramStep;
    //     }
    // }
}
