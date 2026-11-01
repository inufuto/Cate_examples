#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
                #include "VVram.h"

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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 9 + 32 * VramStep, "STAGE");
    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    word vram = PrintNumber5(Vram + VramRowSize * 2 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + VramRowSize * 9 + 38 * VramStep, CurrentStage + 1);
}

void PrintRemain()
{
    word vram = Vram + VramRowSize * 23 + 33 * VramStep;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 5) {
            vram = Put(vram, Char_Remain);
            vram = Put(vram, i + 0x02);
            i -= 2;
            while (i != 0) {
                vram = Put(vram, Char_Space);
                --i;
            }
        }
        else {
            do {
                vram = Put(vram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    vram = Put(vram, Char_Space);
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
            0x4c, 0x46, 0x00, 0x00, 
            0x4b, 0x42, 0x4b, 0x4a, 
            0x4b, 0x42, 0x4b, 0x46, 
            0x44, 0x44, 0x43, 0x40, 
            0x00, 0x00, 0x00, 0x00, 
            0x47, 0x4e, 0x4b, 0x46, 
            0x46, 0x4e, 0x4b, 0x4a, 
            0x00, 0x44, 0x43, 0x40, 
            0x00, 0x00, 0x00, 0x00, 
            0x4a, 0x4b, 0x46, 0x44, 
            0x46, 0x4b, 0x46, 0x40, 
            0x00, 0x43, 0x44, 0x44, 
            0x00, 0x00, 0x00, 0x00, 
            0x43, 0x4e, 0x40, 0x4e, 
            0x00, 0x4e, 0x00, 0x4e, 
            0x00, 0x44, 0x00, 0x43, 
            0x00, 0x00, 0x00, 0x00, 
            0x4b, 0x42, 0x4d, 0x44, 
            0x4b, 0x42, 0x44, 0x4c, 
            0x44, 0x00, 0x44, 0x44, 
            0x00, 0x00, 0x42, 0x00, 
            0x40, 0x44, 0x46, 0x40, 
            0x41, 0x00, 0x40, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        ptr<byte> p;
        word vram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 21 + 9 * VramStep, "OR ALT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2026");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // {
    //     ptr<byte> pVVram = VVram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         *pVVram = c; ++pVVram;
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVVram += VVramWidth - 16;
    //         }
    //     }
    //     BeginDraw();
    //     DrawSprite1(2, 2, 2);
    //     DrawSprite1(5, 2, 2);
    //     DrawSprite1(2, 5, 2);
    //     DrawSprite1(5, 5, 2);
    //     EndDraw();
    // }
}
