#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Movable.h"
#include "Actor.h"
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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
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
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 11 + 10;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x48, 0x47, 0x4d, 0x42, 
		0x4f, 0x40, 0x40, 0x40, 
		0x4d, 0x42, 0x48, 0x42, 
		0x40, 0x45, 0x45, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x44, 0x4d, 0x42, 0x4e, 
		0x4e, 0x4d, 0x43, 0x4f, 
		0x44, 0x45, 0x41, 0x44, 
		0x40, 0x40, 0x40, 0x40, 
		0x4d, 0x42, 0x4e, 0x4d, 
		0x48, 0x42, 0x4f, 0x4c, 
		0x45, 0x40, 0x44, 0x45, 
		0x40, 0x40, 0x40, 0x40, 
		0x42, 0x4f, 0x46, 0x41, 
		0x43, 0x4f, 0x40, 0x40, 
		0x40, 0x45, 0x40, 0x40, 
		0x40, 0x40, 0x40, 0x40, 
		0x4f, 0x4d, 0x4d, 0x42, 
		0x4f, 0x4c, 0x4c, 0x43, 
		0x45, 0x44, 0x44, 0x41, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + 6;
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
    PrintS(Vram + VramRowSize * 19 + 12 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 20 + 12 * VramStep, "X:CONTINUE");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     byte c = 0;
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         c++;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - VramStep * 16;
    //         }
    //     }
    // }
}