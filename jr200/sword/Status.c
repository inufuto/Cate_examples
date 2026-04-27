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
            pVram = Put2C(pVram, Char_Remain, 0x45);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain, 0x45);
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
		0x20, 0xf6, 0xee, 0xe3, 
		0x20, 0xe6, 0x94, 0xf3, 
		0x20, 0x94, 0x20, 0x8e, 
		0x20, 0xfa, 0xee, 0xf8, 
		0xe8, 0xf2, 0xf3, 0x8e, 
		0xe8, 0xf2, 0xf2, 0x8e, 
		0xfa, 0xee, 0xee, 0xf8, 
		0x20, 0x20, 0x20, 0x20, 
		0xe1, 0xe4, 0xe3, 0xe8, 
		0xe8, 0xf2, 0x8e, 0xe8, 
		0x20, 0xee, 0xf8, 0xfa, 
		0x20, 0x20, 0x20, 0x20, 
		0xe4, 0xe3, 0xe8, 0xe4, 
		0xe3, 0xe4, 0xe8, 0xf2, 
		0xf8, 0xee, 0xfa, 0xee, 
		0x20, 0x20, 0x20, 0x20, 
		0xe3, 0x20, 0x8e, 0xe1, 
		0x8e, 0x20, 0x8e, 0xe8, 
		0xf8, 0x20, 0x8e, 0xe8, 
		0x20, 0x20, 0xee, 0xee, 
		0xe8, 0xf2, 0x20, 0x20, 
		0xe8, 0xf2, 0xf6, 0xe6, 
		0xe8, 0xf2, 0x8e, 0xe8, 
		0xee, 0x20, 0xfa, 0xee, 
		0x20, 0x20, 0x20, 0x20, 
		0xf3, 0x8e, 0xe6, 0xf3, 
		0xf2, 0x8e, 0xf6, 0xf8, 
		0x20, 0xee, 0xfa, 0xf8, 
		0x20, 0x20, 0x20, 0x20, 
		0x8e, 0xe1, 0xe4, 0x20, 
		0x8e, 0xe6, 0xf3, 0x20, 
		0xee, 0x20, 0xee, 0x20, 
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
                    pVram = Put(pVram, *p, 6);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR RETURN KEY");
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