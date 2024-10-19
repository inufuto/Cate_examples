#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "Stage.h"
#include "Card.h"

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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 10 * VramStep, "TIME");
    {
        ptr<byte> pVram;
        pVram = Vram + 17 * VramStep;
        if (RemainSolverCount > 1) {
            Put2C(pVram, Char_Remain);
            if (RemainSolverCount > 2) {
                PrintC(pVram + (VramRowSize + 2 * VramStep), RemainSolverCount + ('0' - 1));
            }
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldCard();
}

void PrintScore()
{
    ptr<byte> pVram;
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

void PrintHeldCard() 
{
    if (pHeldCard != nullptr) {
        byte pattern;
        pattern = Char_Card + ((pHeldCard->status & 0xf) << 2);
        Put2C(Vram + 15 * VramStep, pattern);
    }
    else {
        Erase2(Vram + 15 * VramStep);
    }
}

void PrintGameOver()
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (StageWidth - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    // EraseWindow();
    PrintS(Vram + VramRowSize * 7 + (StageWidth - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    HScroll = 0;
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x40, 0x4f, 0x4d, 0x42, 
            0x40, 0x4f, 0x4c, 0x43, 
            0x40, 0x4f, 0x4c, 0x43, 
            0x40, 0x45, 0x44, 0x41, 
            0x4f, 0x45, 0x41, 0x4f, 
            0x4f, 0x4a, 0x42, 0x4f, 
            0x4f, 0x40, 0x40, 0x4f, 
            0x45, 0x45, 0x41, 0x44, 
            0x4c, 0x43, 0x4f, 0x4d, 
            0x4c, 0x43, 0x4f, 0x4e, 
            0x4c, 0x43, 0x4f, 0x4c, 
            0x45, 0x40, 0x45, 0x44, 
            0x42, 0x4e, 0x4d, 0x42, 
            0x41, 0x4f, 0x4c, 0x43, 
            0x43, 0x4f, 0x4d, 0x43, 
            0x41, 0x45, 0x44, 0x41, 
            0x4e, 0x4d, 0x42, 0x40, 
            0x4d, 0x4a, 0x40, 0x40, 
            0x4a, 0x4c, 0x43, 0x40, 
            0x44, 0x45, 0x40, 0x40, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> pVram = Vram + VramRowSize * 6 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 10 + ((20 + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 1 * VramStep, "PUSH START BUTTON");
    PrintS(Vram + VramRowSize * 15 + 8 * VramStep, "INUFUTO 2024");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}