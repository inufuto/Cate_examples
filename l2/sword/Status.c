#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Sprite.h"
#include "Man.h"

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
            pVram = Put2S(pVram, ManChars);
            Erase2(pVram);
            PrintC(pVram + VramRowSize, i + '0');
        }
        else {
            do {
                pVram = Put2S(pVram, ManChars);
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
        0x00, 0x07, 0x0e, 0x05, 
        0x00, 0x0a, 0x0f, 0x03, 
        0x00, 0x0f, 0x00, 0x0d, 
        0x00, 0x08, 0x0e, 0x06, 
        0x04, 0x09, 0x03, 0x0d, 
        0x04, 0x09, 0x09, 0x0d, 
        0x08, 0x0e, 0x0e, 0x06, 
        0x00, 0x00, 0x00, 0x00, 
        0x0c, 0x01, 0x05, 0x04, 
        0x04, 0x09, 0x0d, 0x04, 
        0x00, 0x0e, 0x06, 0x08, 
        0x00, 0x00, 0x00, 0x00, 
        0x01, 0x05, 0x04, 0x01, 
        0x05, 0x01, 0x04, 0x09, 
        0x06, 0x0e, 0x08, 0x0e, 
        0x00, 0x00, 0x00, 0x00, 
        0x05, 0x00, 0x0d, 0x0c, 
        0x0d, 0x00, 0x0d, 0x04, 
        0x06, 0x00, 0x0d, 0x04, 
        0x00, 0x00, 0x0e, 0x0e, 
        0x04, 0x09, 0x00, 0x00, 
        0x04, 0x09, 0x07, 0x0a, 
        0x04, 0x09, 0x0d, 0x04, 
        0x0e, 0x00, 0x08, 0x0e, 
        0x00, 0x00, 0x00, 0x00, 
        0x03, 0x0d, 0x0a, 0x03, 
        0x09, 0x0d, 0x07, 0x06, 
        0x00, 0x0e, 0x08, 0x06, 
        0x00, 0x00, 0x00, 0x00, 
        0x0d, 0x0c, 0x01, 0x00, 
        0x0d, 0x0a, 0x03, 0x00, 
        0x0e, 0x00, 0x0e, 0x00, 
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
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR 'Z' KEY");
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