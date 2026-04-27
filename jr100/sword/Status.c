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
            pVram = Put2C(pVram, Char_Man);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Man);
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
		0x00, 0x76, 0x6e, 0x63, 
		0x00, 0x66, 0x54, 0x73, 
		0x00, 0x54, 0x00, 0x4e, 
		0x00, 0x7a, 0x6e, 0x78, 
		0x68, 0x72, 0x73, 0x4e, 
		0x68, 0x72, 0x72, 0x4e, 
		0x7a, 0x6e, 0x6e, 0x78, 
		0x00, 0x00, 0x00, 0x00, 
		0x61, 0x64, 0x63, 0x68, 
		0x68, 0x72, 0x4e, 0x68, 
		0x00, 0x6e, 0x78, 0x7a, 
		0x00, 0x00, 0x00, 0x00, 
		0x64, 0x63, 0x68, 0x64, 
		0x63, 0x64, 0x68, 0x72, 
		0x78, 0x6e, 0x7a, 0x6e, 
		0x00, 0x00, 0x00, 0x00, 
		0x63, 0x00, 0x4e, 0x61, 
		0x4e, 0x00, 0x4e, 0x68, 
		0x78, 0x00, 0x4e, 0x68, 
		0x00, 0x00, 0x6e, 0x6e, 
		0x68, 0x72, 0x00, 0x00, 
		0x68, 0x72, 0x76, 0x66, 
		0x68, 0x72, 0x4e, 0x68, 
		0x6e, 0x00, 0x7a, 0x6e, 
		0x00, 0x00, 0x00, 0x00, 
		0x73, 0x4e, 0x66, 0x73, 
		0x72, 0x4e, 0x76, 0x78, 
		0x00, 0x6e, 0x7a, 0x78, 
		0x00, 0x00, 0x00, 0x00, 
		0x4e, 0x61, 0x64, 0x00, 
		0x4e, 0x66, 0x73, 0x00, 
		0x6e, 0x00, 0x6e, 0x00, 
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
    PrintS(Vram + VramRowSize * 19 + 12 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 20 + 12 * VramStep, "X:CONTINUE");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End0 - Char_Cent) {
    //         pVram = Put(pVram, c, 0x47);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}