#include "Status.h"
#include "Vram.h"
#include "Stage.h"
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
            do {
                byte c;
                c = Char_Man;
                repeat (2) {
                    repeat (2) {
                        pVram = Put(pVram, c);
                        ++c;
                    }
                    pVram += VramRowSize - 2 * VramStep;
                }
                pVram += 3 * VramStep - VramRowSize * 2;
                --i;
            } while (i > 0);
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

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 10 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
    PresentVram();
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
    PresentVram();
}

void Title()
{
    static const byte[] TitleBytes = {
		0x4f, 0x45, 0x4d, 0x42, 
		0x4f, 0x4a, 0x4e, 0x41, 
		0x4f, 0x40, 0x4c, 0x43, 
		0x45, 0x45, 0x45, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x4e, 0x4d, 0x42, 0x4e, 
		0x4f, 0x4c, 0x43, 0x4f, 
		0x44, 0x45, 0x40, 0x44, 
		0x40, 0x40, 0x48, 0x42, 
		0x4d, 0x42, 0x4d, 0x47, 
		0x4c, 0x43, 0x4c, 0x43, 
		0x45, 0x40, 0x40, 0x45, 
		0x40, 0x40, 0x40, 0x4c, 
		0x48, 0x47, 0x45, 0x4c, 
		0x40, 0x45, 0x4b, 0x4c, 
		0x44, 0x45, 0x41, 0x44, 
		0x43, 0x40, 0x40, 0x40, 
		0x4b, 0x47, 0x48, 0x47, 
		0x4f, 0x42, 0x4c, 0x47, 
		0x41, 0x45, 0x40, 0x45, 
		0x40, 0x4c, 0x43, 0x4f, 
		0x4b, 0x4c, 0x43, 0x4f, 
		0x45, 0x4c, 0x43, 0x4f, 
		0x41, 0x44, 0x41, 0x45, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8 + 4 * VramStep;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + VramRowSize * 20 + 6 * VramStep, "PUSH TRIGGER BUTTON");
    // {
    //     byte c;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}


void DrawFence()
{
    ptr<byte> pTop = Vram;
    ptr<byte> pBottom = Vram + VramRowSize * 23;
    repeat(StageWidth) {
        pTop = Put(pTop, Char_Fence);
        pBottom = Put(pBottom, Char_Fence + 1);
    }
    PresentVram();
}