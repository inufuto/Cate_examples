#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte RemainColor = 0x47;
constexpr byte FoodColor = 0x46;
constexpr byte LogoColor = 0x05;

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
                pVram = Put2C(pVram, Char_Remain, RemainColor);
                pVram = Put(pVram, Char_Space, RemainColor);
                pVram = Put(pVram, Char_Space, RemainColor);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10, RemainColor);
                pVram = Put(pVram, Char_Space, RemainColor);
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain, RemainColor);
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
    ptr<byte> pVram = Put2C(Vram + 22 * VramStep, Char_Food, FoodColor);
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
            0x20, 0xe8, 0xe3, 0xe1, 
            0x20, 0xe8, 0xe4, 0xe4, 
            0x20, 0xe8, 0xf2, 0x20, 
            0x20, 0xfa, 0xf8, 0x20, 
            0x8e, 0xe1, 0xf3, 0x20, 
            0x8e, 0xe1, 0xf3, 0xf6, 
            0x8e, 0xe8, 0xf2, 0x8e, 
            0xee, 0xfa, 0xf8, 0xfa, 
            0x20, 0x20, 0x20, 0x20, 
            0xe6, 0xf3, 0x8e, 0xe8, 
            0xee, 0xf8, 0xfa, 0xe6, 
            0xee, 0x20, 0xee, 0xee, 
            0x20, 0x20, 0x20, 0x20, 
            0xf2, 0xf6, 0xe6, 0xf3, 
            0xf2, 0x8e, 0xee, 0xf8, 
            0x20, 0xfa, 0xee, 0xf8, 
            0x20, 0x20, 0x20, 0x20, 
            0x8e, 0xe6, 0xf3, 0x20, 
            0x8e, 0xe8, 0xf2, 0x20, 
            0xee, 0xfa, 0xf8, 0x20, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p, LogoColor);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR RETURN KEY");
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