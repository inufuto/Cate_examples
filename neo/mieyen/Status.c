#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

static byte PrintS(byte x, byte y, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        x = PrintC(x, y, c);
        ++p;
    }
    return x;
}

void PrintStatus() 
{
    PrintS(32, 1, "SCORE"); 
    PrintS(32, 5, "HI-SCORE");
    PrintS(32, 9, "STAGE");
    PrintByteNumber2(38, 9, CurrentStage + 1);
    {
        constexpr byte y = 21;
        byte x = 33;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                x = Put2C(x, y, Char_Remain);
                x = Put(x, y, Char_Space);
                x = Put(x, y, Char_Space);
                x -= 2;
                x = Put(x, y, i + 0x10);
                x = Put(x, y, Char_Space);
            }
            else {
                do {
                    x = Put2C(x, y, Char_Remain);
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
        constexpr byte y = 2;
        byte x = PrintNumber5(34, y, Score);
        PrintC(x, y, '0');
    }
    {
        constexpr byte y = 6;
        byte x = PrintNumber5(34, y, HiScore);
        PrintC(x, y, '0');
    }
}

void PrintFoodCount()
{
    constexpr byte y = 18;
    byte x = Put2C(34, y, Char_Food);
    PrintC(x, y + 1, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(12, 11, "GAME OVER");
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
        byte x = (32 - LogoLength * 4) / 2;
        byte y = 8;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    x = Put(x, y, *p);
                    ++p;
                }
                x -= 4; ++y;
            }
            x += 4; y -= 4;
        }
    }
    PrintS(11, 20, "PUSH Z KEY");
    PrintS(11, 21, "OR X KEY");
    PrintS(20, 22, "INUFUTO 2025");
    // {
    //     byte x = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         x = Put(x, y, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
