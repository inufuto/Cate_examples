#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr ptr<byte> FrontLeft = Vram + 2 * VramStep;

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
    PrintS(FrontLeft + 16 * VramStep, "ST");
    PrintByteNumber2(FrontLeft + VramRowSize + 16 * VramStep, CurrentStage + 1);
    PrintS(FrontLeft + 20 * VramStep, "TIME");
    {
        ptr<byte> pVram = FrontLeft + 27 * VramStep;
        if (RemainCount > 1) {
            pVram = Put(pVram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += VramRowSize - VramStep;
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    Put(FrontLeft + 25 * VramStep, Char_Knife);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(FrontLeft + VramRowSize * VramStep, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(FrontLeft + VramRowSize + 9 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(FrontLeft + VramRowSize + 21 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(FrontLeft + VramRowSize + 25 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x2b, 0x26, 0x26, 0x2a, 
            0x2b, 0x22, 0x22, 0x2e, 
            0x2b, 0x22, 0x22, 0x2e, 
            0x23, 0x20, 0x20, 0x24, 
            //	A
            0x1f, 0x2d, 0x2c, 0x21, 
            0x2b, 0x22, 0x1f, 0x2e, 
            0x2b, 0x26, 0x24, 0x2e, 
            0x23, 0x20, 0x1f, 0x24, 
            //	Z
            0x23, 0x24, 0x2c, 0x26, 
            0x1f, 0x27, 0x26, 0x1f, 
            0x27, 0x26, 0x1f, 0x1f, 
            0x23, 0x24, 0x24, 0x24, 
            //	Y
            0x2b, 0x22, 0x2b, 0x22, 
            0x23, 0x2a, 0x2d, 0x20, 
            0x1f, 0x2b, 0x22, 0x1f, 
            0x1f, 0x23, 0x20, 0x1f, 
            //	2
            0x27, 0x26, 0x24, 0x2a, 
            0x1f, 0x27, 0x2d, 0x26, 
            0x27, 0x2e, 0x24, 0x1f, 
            0x23, 0x24, 0x24, 0x24, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
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
    PrintS(Vram + VramWidth * 20 + 6, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 18 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 2;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}