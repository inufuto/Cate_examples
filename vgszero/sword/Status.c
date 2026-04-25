#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(VramFront + 8 * VramStep, "HI-SCORE");
    PrintS(VramFront + 17 * VramStep, "STAGE");
    PrintByteNumber2(VramFront + VramRowSize + 18 * VramStep, CurrentStage + 1);

    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(VramFront + VramRowSize + 1 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(VramFront + VramRowSize + 10 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = VramFront + 27 * VramStep;
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
    PrintS(VramFront + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
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
    ClearScreen();
    HScroll = 0;
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = VramBack + VramRowSize * 7 + (32 - 8 * 4) / 2 * VramStep;
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
    PrintS(VramBack + VramRowSize * 20 + 7 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2026");
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