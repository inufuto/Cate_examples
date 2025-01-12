#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    {
        ptr<byte> pVram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    Put2C(pVram, Char_Remain);
                    pVram += 2 * VramStep;
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + VramRowSize * 18 + 34 * VramStep, Char_Food);
    PrintC(pVram + VramRowSize, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x20, 0x2c, 0x2b, 0x28, 
            0x20, 0x2c, 0x27, 0x27, 
            0x20, 0x2c, 0x23, 0x20, 
            0x20, 0x24, 0x21, 0x20, 
            0x2f, 0x28, 0x22, 0x20, 
            0x2f, 0x28, 0x22, 0x2e, 
            0x2f, 0x2c, 0x23, 0x2f, 
            0x25, 0x24, 0x21, 0x24, 
            0x20, 0x20, 0x20, 0x20, 
            0x2d, 0x22, 0x2f, 0x2c, 
            0x25, 0x21, 0x24, 0x2d, 
            0x25, 0x20, 0x25, 0x25, 
            0x20, 0x20, 0x20, 0x20, 
            0x23, 0x2e, 0x2d, 0x22, 
            0x23, 0x2f, 0x25, 0x21, 
            0x20, 0x24, 0x25, 0x21, 
            0x20, 0x20, 0x20, 0x20, 
            0x2f, 0x2d, 0x22, 0x20, 
            0x2f, 0x2c, 0x23, 0x20, 
            0x25, 0x24, 0x21, 0x20, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> pVram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
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
    PrintS(Vram + VramRowSize * 20 + 7, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 22 + 20 * VramStep, "INUFUTO 2025");
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
