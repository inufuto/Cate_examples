#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "Rader.h"

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
    // ClearScreen();

    PrintS(VramBack + 23 * VramStep, "SCORE");
    PrintS(VramBack + VramRowSize * 3 + 23 * VramStep, "HI-SCORE");
    PrintS(VramBack + VramRowSize * 6 + 23 * VramStep, "STAGE");
    PrintByteNumber2(VramBack + VramRowSize * 6 + 29 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(VramBack + VramRowSize + 25 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(VramBack + VramRowSize * 4 + 25 * VramStep, HiScore);
    PrintC(pVram, '0');
}


void PrintRemain()
{
    byte i;
    ptr<byte> pVram = VramBack + VramRowSize * 9 + 23 * VramStep;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            pVram = Put2C(pVram, Char_Remain);
            ++i;
        }
    }
    else {
        pVram = Put2C(pVram, Char_Remain);
        pVram = Erase2(pVram);
        PrintByteNumber2(VramBack + VramRowSize * 10 + 25 * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        pVram = Erase2(pVram);
        ++i;
    }
}


void PrintGameOver()
{
    PrintS(VramBack + VramRowSize * 12 + 7 * VramStep, "GAME OVER");
}


static const byte[] TitleBytes = {
    0x40, 0x4c, 0x47, 0x4b, 
    0x40, 0x4c, 0x4b, 0x47, 
    0x40, 0x4c, 0x43, 0x4f, 
    0x40, 0x44, 0x41, 0x45, 
    0x4c, 0x43, 0x4f, 0x4c, 
    0x4c, 0x43, 0x4f, 0x4c, 
    0x4c, 0x43, 0x4f, 0x4c, 
    0x40, 0x45, 0x41, 0x44, 
    0x47, 0x4b, 0x44, 0x4f, 
    0x4b, 0x47, 0x40, 0x4f, 
    0x43, 0x40, 0x40, 0x4f, 
    0x41, 0x40, 0x40, 0x45, 
    0x41, 0x4f, 0x4c, 0x43, 
    0x40, 0x4f, 0x4c, 0x43, 
    0x40, 0x4f, 0x4c, 0x43, 
    0x40, 0x44, 0x45, 0x40, 
    0x4e, 0x4d, 0x42, 0x40, 
    0x4d, 0x4a, 0x40, 0x40, 
    0x4a, 0x4c, 0x43, 0x40, 
    0x44, 0x45, 0x40, 0x40, 
};

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();

    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = VramBack + VramRowSize * 8 + 2 * VramStep;
        p = TitleBytes;
        repeat (5) {
            pVram = Put4S(pVram, p);
            p += 16;
        }
    }
    PrintS(VramBack + VramRowSize * 19 + 4 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 11 * VramStep, "INUFUTO 2025");

    // {
    //     byte c;
    //     ptr<byte> v;
    //     v = Vram+32*12*2;
    //     c = 0;
    //     repeat (0) {
    //         VPut(v, c);
    //         ++c;
    //         v+=2;
    //     }
    // }
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = Char_Fort;
    //     repeat (4) {
    //         repeat (6) {
    //             repeat (6) {
    //                 VPut1(pVram, c);
    //                 ++c;
    //                 pVram += VramStep;
    //             }
    //             pVram += VramRowSize - 6 * VramStep;
    //         }
    //         pVram += 6 * VramStep - VramRowSize * 6;
    //     }
    // }
}
