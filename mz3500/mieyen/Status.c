#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    {
        word vram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2 * VramStep;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    Put2C(vram, Char_Remain);
                    vram += 2 * VramStep;
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
    word vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintFoodCount()
{
    word vram = Put2C(Vram + VramRowSize * 18 + 34 * VramStep, Char_Food);
    PrintC(vram + VramRowSize, FoodCount + '0');
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
        word vram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 22 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
