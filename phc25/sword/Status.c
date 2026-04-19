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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);

    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + 28 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Sprite);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Sprite);
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
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x00, 0x2b, 0x22, 0x28, 
		0x00, 0x2a, 0x27, 0x1f, 
		0x00, 0x27, 0x00, 0x2c, 
		0x00, 0x21, 0x22, 0x1e, 
		0x29, 0x20, 0x1f, 0x2c, 
		0x29, 0x20, 0x20, 0x2c, 
		0x21, 0x22, 0x22, 0x1e, 
		0x00, 0x00, 0x00, 0x00, 
		0x25, 0x24, 0x28, 0x29, 
		0x29, 0x20, 0x2c, 0x29, 
		0x00, 0x22, 0x1e, 0x21, 
		0x00, 0x00, 0x00, 0x00, 
		0x24, 0x28, 0x29, 0x24, 
		0x28, 0x24, 0x29, 0x20, 
		0x1e, 0x22, 0x21, 0x22, 
		0x00, 0x00, 0x00, 0x00, 
		0x28, 0x00, 0x2c, 0x25, 
		0x2c, 0x00, 0x2c, 0x29, 
		0x1e, 0x00, 0x2c, 0x29, 
		0x00, 0x00, 0x22, 0x22, 
		0x29, 0x20, 0x00, 0x00, 
		0x29, 0x20, 0x2b, 0x2a, 
		0x29, 0x20, 0x2c, 0x29, 
		0x22, 0x00, 0x21, 0x22, 
		0x00, 0x00, 0x00, 0x00, 
		0x1f, 0x2c, 0x2a, 0x1f, 
		0x20, 0x2c, 0x2b, 0x1e, 
		0x00, 0x22, 0x21, 0x1e, 
		0x00, 0x00, 0x00, 0x00, 
		0x2c, 0x25, 0x24, 0x00, 
		0x2c, 0x2a, 0x1f, 0x00, 
		0x22, 0x00, 0x22, 0x00, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + (32 - 8 * 4) / 2 * VramStep;
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
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
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