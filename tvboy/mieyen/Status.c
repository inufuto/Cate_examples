#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Movable.h"
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
    PrintS(Vram + 0, "SC");
    PrintS(Vram + 9, "HI");
    PrintS(Vram + 18, "ST");
    PrintByteNumber2(Vram + 20, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram + 28 * VramStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = PrintC(pVram, Char_Space);
                pVram = PrintC(pVram, i + 0x30);
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
    ptr<byte> pVram = PrintNumber5(Vram + 2 * VramStep , Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + 11 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + 24 * VramStep, Char_Food);
    PrintC(pVram + VramStep, FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize6 * 6 + 11, "GAME OVER");
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
        ptr<byte> pVram = Vram + VramRowSize5 * 3 + (VramWidth - LogoLength * 4) / 2;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (2) {
                repeat (4) {
                    pVram = Put3(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize3 - 4;
                repeat (4) {
                    pVram = Put2(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize2 - 4;
            }
            pVram += 4 - VramWidth * 10;
        }
    }
    PrintS(Vram + VramRowSize6 * 7 + 7, "PUSH A OR B BUTTON");
    PrintS(Vram + VramWidth * 58 + VramWidth - 12, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put3(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize3 - 16 * VramStep;
    //         }
    //     }
    // }
}
