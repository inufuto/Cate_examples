#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr ptr<byte> Status = VramFront + VramStep;

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
    PrintS(Status + 1 * VramStep, "SCORE");
    PrintS(Status + 7 * VramStep, "HI-SCORE");
    PrintS(Status + 16 * VramStep, "STAGE");
    PrintByteNumber2(Status + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Status + 22 * VramStep, "TIME");
    PrintScore();
    PrintTime();
    PrintRemain();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Status + VramRowSize, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Status + VramRowSize + 9 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Status + VramRowSize + 23 * VramStep, StageTime);
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = VramFront + 28 * VramStep;
    if (RemainCount > 1) {
        pVram = Put2C(pVram, Char_Remain);
        if (RemainCount > 2) {
            Put(pVram + VramRowSize, RemainCount + 0x0f);
        }
        else {
            Put(pVram + VramRowSize, Char_Space);
        }
    }
    if (RemainCount < 2) {
        Erase2(pVram);
    }
}

void PrintGameOver()
{
    PrintS(VramBack + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramBack + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4e, 0x00, 0x4e, 0x00, 
            0x4e, 0x00, 0x4e, 0x47, 
            0x4e, 0x00, 0x4e, 0x4b, 
            0x43, 0x44, 0x40, 0x00, 
            0x00, 0x00, 0x4b, 0x42, 
            0x46, 0x4a, 0x4b, 0x46, 
            0x42, 0x49, 0x43, 0x40, 
            0x44, 0x40, 0x00, 0x00, 
            0x4e, 0x00, 0x00, 0x43, 
            0x4e, 0x47, 0x46, 0x4a, 
            0x44, 0x4b, 0x42, 0x4e, 
            0x00, 0x00, 0x44, 0x40, 
            0x4c, 0x46, 0x40, 0x00, 
            0x4b, 0x42, 0x4d, 0x4c, 
            0x43, 0x40, 0x4e, 0x4b, 
            0x00, 0x00, 0x43, 0x44, 
            0x00, 0x4d, 0x44, 0x40, 
            0x41, 0x43, 0x4c, 0x42, 
            0x42, 0x44, 0x44, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
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
    PrintS(VramBack + VramRowSize * 19 + 7 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram;
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