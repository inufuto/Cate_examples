#include "Status.h"
#include "Vram.h"
#include "Stage.h"
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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
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
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Put2C(Vram + VramRowSize * 18 + 34 * VramStep, Char_Food);
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
    VVramToVram();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0xf0, 0xcf, 0xc0, 
            0x00, 0xf0, 0x3f, 0x3f, 
            0x00, 0xf0, 0x0f, 0x00, 
            0x00, 0x30, 0x03, 0x00, 
            0xff, 0xc0, 0x0c, 0x00, 
            0xff, 0xc0, 0x0c, 0xfc, 
            0xff, 0xf0, 0x0f, 0xff, 
            0x33, 0x30, 0x03, 0x30, 
            0x00, 0x00, 0x00, 0x00, 
            0xf3, 0x0c, 0xff, 0xf0, 
            0x33, 0x03, 0x30, 0xf3, 
            0x33, 0x00, 0x33, 0x33, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0xfc, 0xf3, 0x0c, 
            0x0f, 0xff, 0x33, 0x03, 
            0x00, 0x30, 0x33, 0x03, 
            0x00, 0x00, 0x00, 0x00, 
            0xff, 0xf3, 0x0c, 0x00, 
            0xff, 0xf0, 0x0f, 0x00, 
            0x33, 0x30, 0x03, 0x00, 
        };
        constexpr byte LogoLength = 5;
        constexpr byte Left = (32 - LogoLength * 4) / 2;
        ptr<byte> p;
        ptr<byte> pVram;
        byte x, y;
        pVram = Vram + VramRowSize * 8 + Left * VramStep;
        y = 8; x = Left;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    SetColorXY(x, y, 0xb8);
                    ++p;
                    ++x;
                }
                pVram += VramRowSize - 4 * VramStep;
                x -= 4; ++y;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
            x += 4; y -= 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR GRAPH KEY");
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
