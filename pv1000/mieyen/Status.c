#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 3 * VramStep, "SCORE");
    PrintS(Vram + 9 * VramStep, "HI-SCORE");
    PrintS(Vram + 18 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 21 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram + 28 * VramStep;
        if (RemainCount <= 1) {
            Put(Vram + 29 * VramStep, Char_Space);
            Put(Vram + VramRowSize + 29 * VramStep, Char_Space);
        }
        else {
            Put(Vram + 29 * VramStep, Char_Remain);
            PrintC(Vram + VramRowSize + 29 * VramStep, RemainCount + ('0' - 1));
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 2 * VramStep, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 11 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + 24 * VramStep, Char_Food);
    PrintC(pVram + VramRowSize, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x1f, 0x2b, 0x2a, 0x27, 
            0x1f, 0x2b, 0x26, 0x26, 
            0x1f, 0x2b, 0x22, 0x1f, 
            0x1f, 0x23, 0x20, 0x1f, 
            0x2e, 0x27, 0x21, 0x1f, 
            0x2e, 0x27, 0x21, 0x2d, 
            0x2e, 0x2b, 0x22, 0x2e, 
            0x24, 0x23, 0x20, 0x23, 
            0x1f, 0x1f, 0x1f, 0x1f, 
            0x2c, 0x21, 0x2e, 0x2b, 
            0x24, 0x20, 0x23, 0x2c, 
            0x24, 0x1f, 0x24, 0x24, 
            0x1f, 0x1f, 0x1f, 0x1f, 
            0x22, 0x2d, 0x2c, 0x21, 
            0x22, 0x2e, 0x24, 0x20, 
            0x1f, 0x23, 0x24, 0x20, 
            0x1f, 0x1f, 0x1f, 0x1f, 
            0x2e, 0x2c, 0x21, 0x1f, 
            0x2e, 0x2b, 0x22, 0x1f, 
            0x24, 0x23, 0x20, 0x1f, 
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
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramWidth * 20 + 6, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 18 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
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