#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte RemainColor = 0x47;
constexpr byte KnifeColor = 0x47;
constexpr byte LogoColor = 0x05;

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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22, "TIME");
    {
        ptr<byte> pVram = Vram + 29 * VramStep;
        if (RemainCount > 1) {
            pVram = Put2C(pVram, Char_Remain, RemainColor);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += VramRowSize;
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    Put(Vram + 27 * VramStep, Char_Knife, KnifeColor);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * VramStep, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + VramRowSize + 27 * VramStep, HeldKnifeCount + '0');
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
            0xe8, 0xe4, 0xe4, 0xe3, 
            0xe8, 0xf2, 0xf2, 0x8e, 
            0xe8, 0xf2, 0xf2, 0x8e, 
            0xfa, 0xf8, 0xf8, 0xee, 
            //	A
            0x20, 0xf6, 0xe6, 0xf3, 
            0xe8, 0xf2, 0x20, 0x8e, 
            0xe8, 0xe4, 0xee, 0x8e, 
            0xfa, 0xf8, 0x20, 0xee, 
            //	Z
            0xfa, 0xee, 0xe6, 0xe4, 
            0x20, 0xe1, 0xe4, 0x20, 
            0xe1, 0xe4, 0x20, 0x20, 
            0xfa, 0xee, 0xee, 0xee, 
            //	Y
            0xe8, 0xf2, 0xe8, 0xf2, 
            0xfa, 0xe3, 0xf6, 0xf8, 
            0x20, 0xe8, 0xf2, 0x20, 
            0x20, 0xfa, 0xf8, 0x20, 
            //	2
            0xe1, 0xe4, 0xee, 0xe3, 
            0x20, 0xe1, 0xf6, 0xe4, 
            0xe1, 0x8e, 0xee, 0x20, 
            0xfa, 0xee, 0xee, 0xee, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p, LogoColor);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR RETURN KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
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