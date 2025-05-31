#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Man.h"
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
        ptr<byte> pVram = Vram + 29 * VramStep;
        if (RemainCount > 1) {
            pVram = Put2S(pVram, ManChars);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram += VramRowSize;
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    Put(Vram + 27 * VramStep, 0x13);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize * VramStep, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + VramRowSize + 27 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x85, 0x07, 0x07, 0x82, 
            0x85, 0x05, 0x05, 0x80, 
            0x85, 0x05, 0x05, 0x80, 
            0x02, 0x01, 0x01, 0x03, 
            //	A
            0x00, 0x81, 0x84, 0x04, 
            0x85, 0x05, 0x00, 0x80, 
            0x85, 0x07, 0x03, 0x80, 
            0x02, 0x01, 0x00, 0x03, 
            //	Z
            0x02, 0x03, 0x84, 0x07, 
            0x00, 0x87, 0x07, 0x00, 
            0x87, 0x07, 0x00, 0x00, 
            0x02, 0x03, 0x03, 0x03, 
            //	Y
            0x85, 0x05, 0x85, 0x05, 
            0x02, 0x82, 0x81, 0x01, 
            0x00, 0x85, 0x05, 0x00, 
            0x00, 0x02, 0x01, 0x00, 
            //	2
            0x87, 0x07, 0x03, 0x82, 
            0x00, 0x87, 0x81, 0x07, 
            0x87, 0x80, 0x03, 0x00, 
            0x02, 0x03, 0x03, 0x03, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
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
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}