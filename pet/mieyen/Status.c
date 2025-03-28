#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"

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
                pVram = Put2S(pVram, ManChars);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    pVram = Put2S(pVram, ManChars);
                    pVram += VramStep;
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
    static const byte[] Chars = {
        0xfe, 0xfc, 0x62, 0x62,
    };
    ptr<byte> pVram = Put2S(Vram + VramRowSize * 18 + 34 * VramStep, Chars);
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
            0x20, 0xe1, 0xfc, 0x6c, 
            0x20, 0xe1, 0xec, 0xec, 
            0x20, 0xe1, 0x61, 0x20, 
            0x20, 0x7c, 0x7e, 0x20, 
            0xa0, 0x6c, 0x7b, 0x20, 
            0xa0, 0x6c, 0x7b, 0xfe, 
            0xa0, 0xe1, 0x61, 0xa0, 
            0xe2, 0x7c, 0x7e, 0x7c, 
            0x20, 0x20, 0x20, 0x20, 
            0xfb, 0x7b, 0xa0, 0xe1, 
            0xe2, 0x7e, 0x7c, 0xfb, 
            0xe2, 0x20, 0xe2, 0xe2, 
            0x20, 0x20, 0x20, 0x20, 
            0x61, 0xfe, 0xfb, 0x7b, 
            0x61, 0xa0, 0xe2, 0x7e, 
            0x20, 0x7c, 0xe2, 0x7e, 
            0x20, 0x20, 0x20, 0x20, 
            0xa0, 0xfb, 0x7b, 0x20, 
            0xa0, 0xe1, 0x61, 0x20, 
            0xe2, 0x7c, 0x7e, 0x20, 
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
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 22 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
