#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Chars.h"
#include "Print.h"
#include "CopyMemory.h"
#include "Stage.h"
                    #include "Fort.h"

extern void _deb();

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
    PrintS(VramFront + 2 * VramStep, "SCORE");
    PrintS(VramFront + 9 * VramStep, "HI-SCORE");
    PrintS(VramFront + 19 * VramStep, "STAGE");

    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(VramFront + VramRowSize + 1 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(VramFront + VramRowSize + 11 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(VramFront + VramRowSize + 21 * VramStep, CurrentStage + 1);
}

void PrintRemain()
{
    ptr<byte> pVram = VramFront + 27 * VramStep;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 3) {
            *pVram = Char_Remain; ++pVram;
            *pVram = i + 0x02; ++pVram;
            i -= 2;
            while (i != 0) {
                *pVram = Char_Space; ++pVram;
                --i;
            }
        }
        else {
            do {
                *pVram = Char_Remain; ++pVram;
                --i;
            } while (i != 0);
        }
    }
    *pVram = Char_Space;
}


void PrintGameOver()
{
    PrintS(VramFront + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
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
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> pVram = VramBack + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
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
    PrintS(VramBack + VramRowSize * 20 + 7 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2025");
    // {
    //     UpdateGroundChars(false);
    //     ptr<byte> pVram = VramBack + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // {
    //     // FortCharOffset = 0;
    //     FortDotOffset = 1;
    //     UpdateFortChars();
    //     ptr<byte> pVram = VramBack + VramRowSize * 2 + 16 * VramStep;
    //     byte c = Char_Fort;
    //     repeat (7 * 2) {
    //         repeat (6) {
    //             pVram = Put(pVram, c);
    //             ++c;
    //         }
    //         pVram += VramRowSize - 6 * VramStep;
    //     }
    // }
}
