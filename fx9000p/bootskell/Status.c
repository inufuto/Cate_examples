#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
        pVram = Vram + VramRowSize * 13 + 25 * VramStep;
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

    // pVram = PrintNumber5(Vram + VramRowSize * 6 + 24 * VramStep, HiScore);
    // PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 8 + 27 * VramStep, StageTime);
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
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x4f, 0x45, 0x4d, 0x42, 
            0x4f, 0x4a, 0x4e, 0x41, 
            0x4f, 0x40, 0x4c, 0x43, 
            0x45, 0x45, 0x45, 0x40, 
            0x40, 0x40, 0x40, 0x40, 
            0x4e, 0x4d, 0x42, 0x4e, 
            0x4f, 0x4c, 0x43, 0x4f, 
            0x44, 0x45, 0x40, 0x44, 
            0x40, 0x40, 0x48, 0x42, 
            0x4d, 0x42, 0x4d, 0x47, 
            0x4c, 0x43, 0x4c, 0x43, 
            0x45, 0x40, 0x40, 0x45, 
            0x40, 0x40, 0x40, 0x4c, 
            0x48, 0x47, 0x45, 0x4c, 
            0x40, 0x45, 0x4b, 0x4c, 
            0x44, 0x45, 0x41, 0x44, 
            0x43, 0x40, 0x40, 0x40, 
            0x4b, 0x47, 0x48, 0x47, 
            0x4f, 0x42, 0x4c, 0x47, 
            0x41, 0x45, 0x40, 0x45, 
            0x40, 0x4c, 0x43, 0x4f, 
            0x4b, 0x4c, 0x43, 0x4f, 
            0x45, 0x4c, 0x43, 0x4f, 
            0x41, 0x44, 0x41, 0x45, 
        };
        constexpr byte LogoLength = 6;
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
    //     ptr<byte> pVram;
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


void DrawFence()
{
    ptr<byte> top = Vram;
    ptr<byte> bottom = Vram + VramRowSize * 15;
    repeat(StageWidth) {
        top = Put(top, Char_Fence);
        bottom = Put(bottom, Char_Fence + 1);
    }
}