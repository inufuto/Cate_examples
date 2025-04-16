#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_MyFighter;

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
    PrintS(Vram + VramRowSize * 1 + 24 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + 24 * VramStep, "STAGE");

    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 24 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 5 + 28 * VramStep, CurrentStage + 1);
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = Vram + VramRowSize * 12 + 25 * VramStep;
    if (RemainCount >= 3 + 1) {
        pVram = Put2C(pVram, Char_Remain);
        Erase2(pVram);
        pVram = PrintC(pVram, RemainCount + ('0' - 1));
    }
    else {
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i > 0);
        }
        if (RemainCount < 3) {
            Erase2(pVram);
        }
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + 8 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	E
            0x4c, 0x47, 0x45, 0x41, 
            0x4c, 0x4b, 0x4a, 0x42, 
            0x4c, 0x43, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
            //	R
            0x4c, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x48, 0x4f, 
            0x4c, 0x47, 0x4f, 0x42, 
            0x44, 0x41, 0x44, 0x45, 
            //	I
            0x44, 0x4d, 0x47, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x4c, 0x43, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	L
            0x4c, 0x43, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x4c, 0x43, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 4 + (6 - LogoLength) * 2 * VramStep;
        p = TitleBytes;
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
        PrintS(Vram + VramRowSize * 8 + (24 - (6 - LogoLength) * 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 11 + 8 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "X:CONTINUE");
    PrintS(Vram + VramRowSize * 15 + 12 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0xff) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
