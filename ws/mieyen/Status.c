#include "Status.h"
#include "Vram.h"
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
    PrintS(VramFront + 1 * VramStep, "SCORE");
    PrintS(VramFront + 7 * VramStep, "STAGE");
    PrintByteNumber2(VramFront + VramRowSize + 10 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = VramFront + 20 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
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
    ptr<byte> pVram = PrintNumber5(VramFront + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(VramFront + 14 * VramStep, Char_Food);
    PrintC(pVram + VramRowSize, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(VramFront + VramRowSize * 7 + (24 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramFront + VramRowSize * 7 + (24 - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
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
        constexpr byte LogoLeft = (VramWidth - 4 * LogoLength) / 2;
        ptr<byte> pVram = VramFront + VramRowSize * 4 + LogoLeft * VramStep;
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
        PrintS(VramFront + VramRowSize * 8 + (LogoLeft + LogoLength * 4 - 4) * VramStep, "MINI");
    }
    PrintS(VramFront + VramRowSize * 13 + 3 * VramStep, "PUSH START BUTTON");
    PrintS(VramFront + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = VramFront+VramRowSize*2;
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