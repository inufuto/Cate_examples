#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Sprite.h"
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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 19 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram + 27 * VramStep;
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
    static const byte[] Chars = {
        0x07, 0x05, 0x0f, 0x0f,
    };
    ptr<byte> pVram = Put2S(Vram + 22 * VramStep, Chars);
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
            0x00, 0x04, 0x05, 0x0c, 
            0x00, 0x04, 0x01, 0x01, 
            0x00, 0x04, 0x09, 0x00, 
            0x00, 0x08, 0x06, 0x00, 
            0x0d, 0x0c, 0x03, 0x00, 
            0x0d, 0x0c, 0x03, 0x07, 
            0x0d, 0x04, 0x09, 0x0d, 
            0x0e, 0x08, 0x06, 0x08, 
            0x00, 0x00, 0x00, 0x00, 
            0x0a, 0x03, 0x0d, 0x04, 
            0x0e, 0x06, 0x08, 0x0a, 
            0x0e, 0x00, 0x0e, 0x0e, 
            0x00, 0x00, 0x00, 0x00, 
            0x09, 0x07, 0x0a, 0x03, 
            0x09, 0x0d, 0x0e, 0x06, 
            0x00, 0x08, 0x0e, 0x06, 
            0x00, 0x00, 0x00, 0x00, 
            0x0d, 0x0a, 0x03, 0x00, 
            0x0d, 0x04, 0x09, 0x00, 
            0x0e, 0x08, 0x06, 0x00, 
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
    PrintS(Vram + VramWidth * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 20 + 9, "OR 'Z' KEY");
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