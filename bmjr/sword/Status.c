#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
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
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram = Vram + 28 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Sprite);
            Erase2(vram);
            PrintC(vram + VramRowSize, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Sprite);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
		0x00, 0x2d, 0x24, 0x2a, 
		0x00, 0x2c, 0x29, 0x21, 
		0x00, 0x29, 0x00, 0x2e, 
		0x00, 0x23, 0x24, 0x20, 
		0x2b, 0x22, 0x21, 0x2e, 
		0x2b, 0x22, 0x22, 0x2e, 
		0x23, 0x24, 0x24, 0x20, 
		0x00, 0x00, 0x00, 0x00, 
		0x27, 0x26, 0x2a, 0x2b, 
		0x2b, 0x22, 0x2e, 0x2b, 
		0x00, 0x24, 0x20, 0x23, 
		0x00, 0x00, 0x00, 0x00, 
		0x26, 0x2a, 0x2b, 0x26, 
		0x2a, 0x26, 0x2b, 0x22, 
		0x20, 0x24, 0x23, 0x24, 
		0x00, 0x00, 0x00, 0x00, 
		0x2a, 0x00, 0x2e, 0x27, 
		0x2e, 0x00, 0x2e, 0x2b, 
		0x20, 0x00, 0x2e, 0x2b, 
		0x00, 0x00, 0x24, 0x24, 
		0x2b, 0x22, 0x00, 0x00, 
		0x2b, 0x22, 0x2d, 0x2c, 
		0x2b, 0x22, 0x2e, 0x2b, 
		0x24, 0x00, 0x23, 0x24, 
		0x00, 0x00, 0x00, 0x00, 
		0x21, 0x2e, 0x2c, 0x21, 
		0x22, 0x2e, 0x2d, 0x20, 
		0x00, 0x24, 0x23, 0x20, 
		0x00, 0x00, 0x00, 0x00, 
		0x2e, 0x27, 0x26, 0x00, 
		0x2e, 0x2c, 0x21, 0x00, 
		0x24, 0x00, 0x24, 0x00, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 8 * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (8) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR 'Z' KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}