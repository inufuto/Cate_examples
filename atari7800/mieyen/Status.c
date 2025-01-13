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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 19 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram + 27 * VramStep;
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
                    pVram += 2;
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
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + 22 * VramStep, Char_Food);
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
    UpdateSprites();
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
    PrintS(Vram + VramWidth * 19 + 6, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
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