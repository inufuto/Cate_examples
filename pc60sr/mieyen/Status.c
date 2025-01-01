#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

static word PrintS(word yx, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        yx = PrintC(yx, c);
        ++p;
    }
    return yx;
}

void PrintStatus() 
{
    PrintS(YStep * 1 + 32 * XStep, "SCORE");
    PrintS(YStep * 5 + 32 * XStep, "HI-SCORE");
    PrintS(YStep * 9 + 32 * XStep, "STAGE");
    PrintByteNumber2(YStep * 9 + 38 * XStep, CurrentStage + 1);
    {
        word yx = YStep * 21 + 33 * XStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                Put2C(yx, Char_Remain);
                yx += 2 * XStep;
                yx = Put(yx, Char_Space);
                yx = Put(yx, Char_Space);
                yx += YStep - 2 * XStep;
                yx = Put(yx, i + 0x10);
                yx = Put(yx, Char_Space);
            }
            else {
                do {
                    Put2C(yx, Char_Remain);
                    yx += 2 * XStep;
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
    word yx = PrintNumber5(YStep * 2 + 34 * XStep, Score);
    PrintC(yx, '0');

    yx = PrintNumber5(YStep * 6 + 34 * XStep, HiScore);
    PrintC(yx, '0');
}

void PrintFoodCount()
{
    word yx = Put2C(YStep * 18 + 34 * XStep, Char_Food);
    PrintC(yx + YStep, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(YStep * 11 + 12 * XStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x40, 0x4c, 0x4b, 0x48, 
            0x40, 0x4c, 0x47, 0x47, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
            0x4f, 0x48, 0x42, 0x40, 
            0x4f, 0x48, 0x42, 0x4e, 
            0x4f, 0x4c, 0x43, 0x4f, 
            0x45, 0x44, 0x41, 0x44, 
            0x40, 0x40, 0x40, 0x40, 
            0x4d, 0x42, 0x4f, 0x4c, 
            0x45, 0x41, 0x44, 0x4d, 
            0x45, 0x40, 0x45, 0x45, 
            0x40, 0x40, 0x40, 0x40, 
            0x43, 0x4e, 0x4d, 0x42, 
            0x43, 0x4f, 0x45, 0x41, 
            0x40, 0x44, 0x45, 0x41, 
            0x40, 0x40, 0x40, 0x40, 
            0x4f, 0x4d, 0x42, 0x40, 
            0x4f, 0x4c, 0x43, 0x40, 
            0x45, 0x44, 0x41, 0x40, 
        };
        constexpr byte LogoLength = 5;
        word yx = YStep * 8 + (32 - LogoLength * 4) / 2 * XStep;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    yx = Put(yx, *p);
                    ++p;
                }
                yx += YStep - 4 * XStep;
            }
            yx += 4 * XStep - YStep * 4;
        }
    }
    PrintS(YStep * 19 + 9 * XStep, "PUSH SPACE KEY");
    PrintS(YStep * 20 + 9 * XStep, "OR SHIFT KEY");
    PrintS(YStep * 22 + 20 * XStep, "INUFUTO 2025");
    // {
    //     word yx = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         yx = Put(yx, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             yx += YStep - 16 * XStep;
    //         }
    //     }
    // }
}
