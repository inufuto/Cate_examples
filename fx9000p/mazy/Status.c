#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Knife.h"

constexpr byte Char_Remain = Char_Man;

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
    PrintS(Vram + VramRowSize * 1 + 24 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 5 + 28 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 7 + 24 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 14 + 25 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                Erase2(pVram);
                pVram = Put(Vram + VramRowSize, i + 0x10);
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 24 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 8 + 27 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    byte count, i;

    pVram = Vram + VramRowSize * 12 + 25 * VramStep;
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
    PrintS(Vram + VramRowSize * 7 + 8 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + 9 * VramStep, "TIME UP");
}

void PrintPerfect()
{
    PrintS(Vram + VramRowSize * 7 + 9 * VramStep, "PERFECT");
}

void Title()
{
    ClearScreen(); 
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x4c, 0x47, 0x47, 0x4b, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x44, 0x41, 0x41, 0x45, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	Z
            0x44, 0x45, 0x4d, 0x47, 
            0x40, 0x48, 0x47, 0x40, 
            0x48, 0x47, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x45, 
            //	Y
            0x4c, 0x43, 0x4c, 0x43, 
            0x44, 0x4b, 0x4e, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
        };
        constexpr byte LogoLength = 4;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 4 + (6 - LogoLength) * 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 8 + (24 - (6 - LogoLength) * 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 11 + 8 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "X:CONTINUE");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> vram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0xff) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
