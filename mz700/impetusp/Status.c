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
    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + VramRowSize * 23 + 33 * VramStep;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 5) {
            pVram = Put(pVram, Char_Remain);
            pVram = Put(pVram, i + 0x02);
            i -= 2;
            while (i != 0) {
                pVram = Put(pVram, Char_Space);
                --i;
            }
        }
        else {
            do {
                pVram = Put(pVram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    pVram = Put(pVram, Char_Space);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x0d, 0x07, 0x00, 0x00, 
            0x0c, 0x03, 0x0c, 0x0b, 
            0x0c, 0x03, 0x0c, 0x07, 
            0x05, 0x05, 0x04, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x08, 0x0f, 0x0c, 0x07, 
            0x07, 0x0f, 0x0c, 0x0b, 
            0x00, 0x05, 0x04, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0b, 0x0c, 0x07, 0x05, 
            0x07, 0x0c, 0x07, 0x01, 
            0x00, 0x04, 0x05, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x04, 0x0f, 0x01, 0x0f, 
            0x00, 0x0f, 0x00, 0x0f, 
            0x00, 0x05, 0x00, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x0c, 0x03, 0x0e, 0x05, 
            0x0c, 0x03, 0x05, 0x0d, 
            0x05, 0x00, 0x05, 0x05, 
            0x00, 0x00, 0x03, 0x00, 
            0x01, 0x05, 0x07, 0x01, 
            0x02, 0x00, 0x01, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        ptr<byte> p;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2;
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
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // {
    //     DrawSprite1(3, 3, 1);
    //     // SwitchVram();
    // }
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = Char_Fort;
    //     while (c < Char_End) {
    //         repeat (6) {
    //             pVram = Put(pVram, c);
    //             ++c;
    //         }
    //         pVram += VramRowSize - 6 * VramStep;
    //     }
    // }
}
