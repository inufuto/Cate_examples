#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Car;

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
    PrintS(Vram + VramRowSize * 12 + 32 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                Erase2(pVram);
                PrintC(pVram, i + '0');
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 12 + 37 * VramStep, StageTime);
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
            0x3f, 0x30, 0x3f, 0x30, 
            0x3d, 0x3a, 0x37, 0x38, 
            0x30, 0x3f, 0x30, 0x3c, 
            0x30, 0x35, 0x30, 0x30, 
            0x30, 0x30, 0x30, 0x30, 
            0x37, 0x3b, 0x3c, 0x33, 
            0x37, 0x35, 0x3c, 0x33, 
            0x35, 0x31, 0x34, 0x35, 
            0x30, 0x30, 0x30, 0x30, 
            0x33, 0x3f, 0x38, 0x37, 
            0x33, 0x3f, 0x3c, 0x33, 
            0x35, 0x31, 0x30, 0x35, 
            0x3f, 0x30, 0x30, 0x30, 
            0x3f, 0x38, 0x37, 0x3b, 
            0x3f, 0x3c, 0x33, 0x3f, 
            0x35, 0x30, 0x35, 0x31, 
            0x30, 0x30, 0x30, 0x30, 
            0x3c, 0x33, 0x33, 0x3f, 
            0x3c, 0x33, 0x33, 0x3f, 
            0x34, 0x35, 0x35, 0x31, 
        };
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 6 * VramStep;
        p = TitleBytes;
        repeat (5) {
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
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void DrawFence()
{
    ptr<byte> pTop, pBottom;
    pTop = Vram;
    pBottom = Vram + VramRowSize * 23;
    repeat(StageWidth) {
        pTop = Put(pTop, Char_Fence);
        pBottom = Put(pBottom, Char_Fence + 1);
    }
}