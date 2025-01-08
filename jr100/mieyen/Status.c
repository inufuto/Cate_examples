#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 19 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
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
    SetPattern(Char_Remain, Pattern_Man, 4);
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x68, 0x63, 0x61, 
            0x00, 0x68, 0x64, 0x64, 
            0x00, 0x68, 0x72, 0x00, 
            0x00, 0x7a, 0x78, 0x00, 
            0x4e, 0x61, 0x73, 0x00, 
            0x4e, 0x61, 0x73, 0x76, 
            0x4e, 0x68, 0x72, 0x4e, 
            0x6e, 0x7a, 0x78, 0x7a, 
            0x00, 0x00, 0x00, 0x00, 
            0x66, 0x73, 0x4e, 0x68, 
            0x6e, 0x78, 0x7a, 0x66, 
            0x6e, 0x00, 0x6e, 0x6e, 
            0x00, 0x00, 0x00, 0x00, 
            0x72, 0x76, 0x66, 0x73, 
            0x72, 0x4e, 0x6e, 0x78, 
            0x00, 0x7a, 0x6e, 0x78, 
            0x00, 0x00, 0x00, 0x00, 
            0x4e, 0x66, 0x73, 0x00, 
            0x4e, 0x68, 0x72, 0x00, 
            0x6e, 0x7a, 0x78, 0x00, 
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
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH 'Z' KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR 'X' KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c, 0x47);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}