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
    PrintS(Vram + 22 * VramStep, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                Erase2(pVram);
                pVram = PrintC(pVram + VramRowSize, i + 0x30);
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
                    --i;
                } while (i != 0);
            }
        }
    }
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 11 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x00, 0x4d, 0x4c, 0x41, 
        0x4b, 0x42, 0x00, 0x4e, 
        0x4b, 0x46, 0x44, 0x4e, 
        0x43, 0x40, 0x00, 0x44, 
        //	W
        0x4b, 0x42, 0x41, 0x4e, 
        0x4b, 0x42, 0x42, 0x4e, 
        0x4b, 0x42, 0x42, 0x4e, 
        0x43, 0x44, 0x44, 0x40, 
        //	A
        0x00, 0x4d, 0x4c, 0x41, 
        0x4b, 0x42, 0x00, 0x4e, 
        0x4b, 0x46, 0x44, 0x4e, 
        0x43, 0x40, 0x00, 0x44, 
        //	S
        0x47, 0x46, 0x44, 0x4a, 
        0x43, 0x4a, 0x49, 0x41, 
        0x47, 0x41, 0x00, 0x4e, 
        0x00, 0x44, 0x44, 0x40, 
        //	S
        0x47, 0x46, 0x44, 0x4a, 
        0x43, 0x4a, 0x49, 0x41, 
        0x47, 0x41, 0x00, 0x4e, 
        0x00, 0x44, 0x44, 0x40, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + (32 - 5 * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (5) {
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
    //     ptr<byte> ppVram = Vram + VramRowSize * 2;
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