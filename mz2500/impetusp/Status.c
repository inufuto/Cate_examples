#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

// extern void UpdateFortChars();

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
            0x2a, 0x24, 0x00, 0x00, 
            0x29, 0x20, 0x29, 0x28, 
            0x29, 0x20, 0x29, 0x24, 
            0x22, 0x22, 0x21, 0x1e, 
            0x00, 0x00, 0x00, 0x00, 
            0x25, 0x2c, 0x29, 0x24, 
            0x24, 0x2c, 0x29, 0x28, 
            0x00, 0x22, 0x21, 0x1e, 
            0x00, 0x00, 0x00, 0x00, 
            0x28, 0x29, 0x24, 0x22, 
            0x24, 0x29, 0x24, 0x1e, 
            0x00, 0x21, 0x22, 0x22, 
            0x00, 0x00, 0x00, 0x00, 
            0x21, 0x2c, 0x1e, 0x2c, 
            0x00, 0x2c, 0x00, 0x2c, 
            0x00, 0x22, 0x00, 0x21, 
            0x00, 0x00, 0x00, 0x00, 
            0x29, 0x20, 0x2b, 0x22, 
            0x29, 0x20, 0x22, 0x2a, 
            0x22, 0x00, 0x22, 0x22, 
            0x00, 0x00, 0x20, 0x00, 
            0x1e, 0x22, 0x24, 0x1e, 
            0x1f, 0x00, 0x1e, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        ptr<byte> p;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
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
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    {
        // do {
            // UpdateGroundChars(true);
            // UpdateGroundChars(false);
            // UpdateFortChars();
            // ptr<byte> pVram = Vram;
            // byte c = 0;
            // repeat (Char_End) {
            //     pVram = Put(pVram, c);
            //     ++c;
            //     if ((c & 0x0f) == 0) {
            //         pVram += VramRowSize - 16 * VramStep;
            //     }
            // }
        //     DotOffset = (DotOffset + 1) & CoordMask;
        // } while (true);
    }
    // {
    //     DrawSprite(0, 0, 22);
    //     DrawSprite(8, 0, 22);
    //     DrawSprite(0, 8, 22);
    //     DrawSprite(8, 8, 22);
    //     DrawSprite(6, 4, 5);
    //     SwitchGVram();
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
