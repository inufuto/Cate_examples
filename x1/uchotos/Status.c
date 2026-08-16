#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");
    PrintScore();
    PrintTime();
    PrintRemain();
}

void PrintScore()
{
    {
        word vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
        PrintC(vram, '0');
    }
    {
        word vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
        PrintC(vram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * VramStep, StageTime);
}

void PrintRemain()
{
    word vram = Vram + VramRowSize * 22 + 33 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            Erase2(vram);
            PrintC(vram + VramRowSize, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x2c, 0x00, 0x2c, 0x00, 
            0x2c, 0x00, 0x2c, 0x25, 
            0x2c, 0x00, 0x2c, 0x29, 
            0x21, 0x22, 0x1e, 0x00, 
            0x00, 0x00, 0x29, 0x20, 
            0x24, 0x28, 0x29, 0x24, 
            0x20, 0x27, 0x21, 0x1e, 
            0x22, 0x1e, 0x00, 0x00, 
            0x2c, 0x00, 0x00, 0x21, 
            0x2c, 0x25, 0x24, 0x28, 
            0x22, 0x29, 0x20, 0x2c, 
            0x00, 0x00, 0x22, 0x1e, 
            0x2a, 0x24, 0x1e, 0x00, 
            0x29, 0x20, 0x2b, 0x2a, 
            0x21, 0x1e, 0x2c, 0x29, 
            0x00, 0x00, 0x21, 0x22, 
            0x00, 0x2b, 0x22, 0x1e, 
            0x1f, 0x21, 0x2a, 0x20, 
            0x20, 0x22, 0x22, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR RETURN KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
