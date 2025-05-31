#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"

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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + 32 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, ManChars);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    pVram = Put2S(pVram, ManChars);
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 19 + 32 * VramStep;
    byte i = HeldKnifeCount;
    while (i != 0) {
        pVram = Put(pVram, 0x3c) + 1;
        --i;
    }
    Put(pVram, Char_Space);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0xe1, 0xec, 0xec, 0xfc, 
            0xe1, 0x61, 0x61, 0xa0, 
            0xe1, 0x61, 0x61, 0xa0, 
            0x7c, 0x7e, 0x7e, 0xe2, 
            //	A
            0x20, 0xfe, 0xfb, 0x7b, 
            0xe1, 0x61, 0x20, 0xa0, 
            0xe1, 0xec, 0xe2, 0xa0, 
            0x7c, 0x7e, 0x20, 0xe2, 
            //	Z
            0x7c, 0xe2, 0xfb, 0xec, 
            0x20, 0x6c, 0xec, 0x20, 
            0x6c, 0xec, 0x20, 0x20, 
            0x7c, 0xe2, 0xe2, 0xe2, 
            //	Y
            0xe1, 0x61, 0xe1, 0x61, 
            0x7c, 0xfc, 0xfe, 0x7e, 
            0x20, 0xe1, 0x61, 0x20, 
            0x20, 0x7c, 0x7e, 0x20, 
            //	2
            0x6c, 0xec, 0xe2, 0xfc, 
            0x20, 0x6c, 0xfe, 0xec, 
            0x6c, 0xa0, 0xe2, 0x20, 
            0x7c, 0xe2, 0xe2, 0xe2, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
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
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
