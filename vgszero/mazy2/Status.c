#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr ptr<byte> FrontLeft = VramFront + VramStep;

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
    PrintS(FrontLeft + 1 * VramStep, "SCORE");
    PrintS(FrontLeft + 7 * VramStep, "HI-SCORE");
    PrintS(FrontLeft + 16 * VramStep, "STAGE");
    PrintByteNumber2(FrontLeft + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(FrontLeft + 22 * VramStep, "TIME");
    {
        ptr<byte> pVram = FrontLeft + 29 * VramStep;
        if (RemainCount > 1) {
            pVram = Put(pVram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += VramRowSize - VramStep;
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    Put(FrontLeft + 27 * VramStep, Char_Knife);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(FrontLeft + VramRowSize, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(FrontLeft + VramRowSize + 9 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(FrontLeft + VramRowSize + 23 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(FrontLeft + VramRowSize + 27 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(VramFront + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramFront + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HScroll = 0;
    HideAllSprites();
    UpdateSprites();
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
            //	2
            0x48, 0x47, 0x45, 0x4b, 
            0x40, 0x48, 0x4e, 0x47, 
            0x48, 0x4f, 0x45, 0x40, 
            0x44, 0x45, 0x45, 0x45, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = VramBack + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
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
    }
    PrintS(VramBack + VramRowSize * 20 + 7 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = VramFront + 2;
    //     byte c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}