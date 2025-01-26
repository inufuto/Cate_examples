#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

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
    // PrintS(Vram + 0 * VramStep, "SC");   
    // PrintS(Vram + 9 * VramStep, "ST");
    PrintByteNumber2(Vram + 7 * VramStep, CurrentStage + 1);
    // PrintC(Vram+ 14 * VramStep, 'T');
    {
        ptr<byte> pVram;
        pVram = Vram + 14 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                pVram = Put2C(pVram, Char_Man);
                --i;
            } while (i > 0);
        }
    }
    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + 0 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + 10 * VramStep, Char_Food);
    pVram += VramStep;
    PrintC(pVram, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 4 + (VramRowSize - 9 * VramStep) / 2, "GAME OVER");
    PresentVram();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            0x00, 0x0c, 0x0b, 0x08, 
            0x00, 0x0c, 0x07, 0x07, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
            0x0f, 0x08, 0x02, 0x00, 
            0x0f, 0x08, 0x02, 0x0e, 
            0x0f, 0x0c, 0x03, 0x0f, 
            0x05, 0x04, 0x01, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x0d, 0x02, 0x0f, 0x0c, 
            0x05, 0x01, 0x04, 0x0d, 
            0x05, 0x00, 0x05, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x0e, 0x0d, 0x02, 
            0x03, 0x0f, 0x05, 0x01, 
            0x00, 0x04, 0x05, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0x0d, 0x02, 0x00, 
            0x0f, 0x0c, 0x03, 0x00, 
            0x05, 0x04, 0x01, 0x00, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> pVram = Vram + VramRowSize * 1 + (VVramWidth - LogoLength * 4) / 2 * CharWidth;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (2) {
                repeat (4) {
                    pVram = PutU(pVram, *p);
                    ++p;
                }
                pVram -= 4 * CharWidth;
                repeat (4) {
                    pVram = PutL(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * CharWidth;
            }
            pVram += 4 * CharWidth - VramRowSize * 2;
        }
        PrintS(Vram + VramRowSize * 3 + (VVramWidth / 2 + LogoLength * 2) * CharWidth - 4 * VramStep, "MINI");
    }

    PrintS(Vram + VramRowSize * 5 + 0 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 7 + 7 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize;
    //     byte c = 0;
    //     while (c < Char_End) {
    //         repeat (16) {
    //             pVram = PutU(pVram, c);
    //             ++c;
    //         }
    //         pVram -= 16 * VramStep;
    //         repeat (16) {
    //             pVram = PutL(pVram, c);
    //             ++c;
    //         }
    //         pVram += VramRowSize - 16 * VramStep;
    //     }
    // }
    PresentVram();
}