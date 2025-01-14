#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 19 * VramStep, CurrentStage + 1);
    {
        word vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    Put2C(vram, Char_Remain);
                    vram += 2;
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
        word vram = PrintNumber5(Vram + VramRowSize, Score);
        PrintC(vram, '0');
    }
    {
        word vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
        PrintC(vram, '0');
    }
}

void PrintFoodCount()
{
    word vram = Put2C(Vram + 22 * VramStep, Char_Food);
    PrintC(vram + VramRowSize, FoodCount + '0');
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
        ptr<byte> p = TitleBytes;
        word vram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4;
            }
            vram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramWidth * 19 + 6, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}