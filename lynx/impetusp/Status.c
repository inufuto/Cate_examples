#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(VramFront + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(VramFront + VramRowSize + 10 * VramStep, CurrentStage + 1);
}

void PrintRemain()
{
    ptr<byte> pVram = VramFront + 19 * VramStep;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 5) {
            pVram = Put(pVram, Char_Remain);
            pVram = Put(pVram, i + 0x02);
            i -= 2;
            while (i != 0) {
                pVram = Put(pVram, Char_Space);
                --i;
            }
        }
        else {
            do {
                pVram = Put(pVram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    pVram = Put(pVram, Char_Space);
}


void PrintGameOver()
{
    PrintS(VramBack + VramRowSize * 7 + (24 - 9) / 2 * VramStep, "GAME OVER");
    DrawAll();
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x29, 0x23, 0x00, 0x00, 
            0x28, 0x1f, 0x28, 0x27, 
            0x28, 0x1f, 0x28, 0x23, 
            0x21, 0x21, 0x20, 0x1d, 
            0x00, 0x00, 0x00, 0x00, 
            0x24, 0x2b, 0x28, 0x23, 
            0x23, 0x2b, 0x28, 0x27, 
            0x00, 0x21, 0x20, 0x1d, 
            0x00, 0x00, 0x00, 0x00, 
            0x27, 0x28, 0x23, 0x21, 
            0x23, 0x28, 0x23, 0x1d, 
            0x00, 0x20, 0x21, 0x21, 
            0x00, 0x00, 0x00, 0x00, 
            0x20, 0x2b, 0x1d, 0x2b, 
            0x00, 0x2b, 0x00, 0x2b, 
            0x00, 0x21, 0x00, 0x20, 
            0x00, 0x00, 0x00, 0x00, 
            0x28, 0x1f, 0x2a, 0x21, 
            0x28, 0x1f, 0x21, 0x29, 
            0x21, 0x00, 0x21, 0x21, 
            0x00, 0x00, 0x1f, 0x00, 
            0x1d, 0x21, 0x23, 0x1d, 
            0x1e, 0x00, 0x1d, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoLength = 6;
        constexpr byte LogoLeft = (24 - 4 * LogoLength) / 2;
        ptr<byte> pVram = VramBack + VramRowSize * 5 + LogoLeft * VramStep;
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
        PrintS(VramBack + VramRowSize * 9 + (LogoLeft + LogoLength * 4 - 4) * VramStep, "MINI");
    }
    PrintS(VramBack + VramRowSize * 14 + 2 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(VramBack + VramRowSize * 16 + 12 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = VramBack + VramRowSize*2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    DrawAll();
}