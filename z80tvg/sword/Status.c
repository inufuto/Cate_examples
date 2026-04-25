#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte Char_Remain = Char_Sprite;

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

    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + VramRowSize * 22 + 33 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
    PresentVram();
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x4d, 0x44, 0x4a, 
            0x00, 0x4c, 0x49, 0x41, 
            0x00, 0x49, 0x00, 0x4e, 
            0x00, 0x43, 0x44, 0x40, 
            0x4b, 0x42, 0x41, 0x4e, 
            0x4b, 0x42, 0x42, 0x4e, 
            0x43, 0x44, 0x44, 0x40, 
            0x00, 0x00, 0x00, 0x00, 
            0x47, 0x46, 0x4a, 0x4b, 
            0x4b, 0x42, 0x4e, 0x4b, 
            0x00, 0x44, 0x40, 0x43, 
            0x00, 0x00, 0x00, 0x00, 
            0x46, 0x4a, 0x4b, 0x46, 
            0x4a, 0x46, 0x4b, 0x42, 
            0x40, 0x44, 0x43, 0x44, 
            0x00, 0x00, 0x00, 0x00, 
            0x4a, 0x00, 0x4e, 0x47, 
            0x4e, 0x00, 0x4e, 0x4b, 
            0x40, 0x00, 0x4e, 0x4b, 
            0x00, 0x00, 0x44, 0x44, 
            0x4b, 0x42, 0x00, 0x00, 
            0x4b, 0x42, 0x4d, 0x4c, 
            0x4b, 0x42, 0x4e, 0x4b, 
            0x44, 0x00, 0x43, 0x44, 
            0x00, 0x00, 0x00, 0x00, 
            0x41, 0x4e, 0x4c, 0x41, 
            0x42, 0x4e, 0x4d, 0x40, 
            0x00, 0x44, 0x43, 0x40, 
            0x00, 0x00, 0x00, 0x00, 
            0x4e, 0x47, 0x46, 0x00, 
            0x4e, 0x4c, 0x41, 0x00, 
            0x44, 0x00, 0x44, 0x00, 
        };
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 0 * VramStep;
        p = TitleBytes;
        repeat (8) {
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
    PrintS(Vram + VramRowSize * 20 + 7 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}

void DrawFence()
{
    ptr<byte> top = Vram + VramRowSize * 1;
    ptr<byte> bottom = Vram + VramRowSize * 24;
    repeat(VVramWidth) {
        top = Put(top, Char_Fence);
        bottom = Put(bottom, Char_Fence + 1);
    }
}