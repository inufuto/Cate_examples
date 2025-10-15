#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte Char_Remain = Char_Man;

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    {
        ptr<byte> pVram;
        pVram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = Put(pVram, Char_Space);
                pVram = Put(pVram, Char_Space);
                pVram += VramRowSize - 2 * VramStep;
                pVram = Put(pVram, i + 0x10);
                pVram = Put(pVram, Char_Space);
            }
            else {
                do {
                    Put2C(pVram, Char_Remain);
                    pVram += 2 * VramStep;
                    --i;
                } while (i > 0);
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
        pVram += VramRowSize - width * VramStep;
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
        //	C
        0x00, 0x0e, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x0b, 0x00, 0x0a, 
        0x00, 0x04, 0x05, 0x01, 
        //	R
        0x0c, 0x07, 0x05, 0x0b, 
        0x0c, 0x03, 0x08, 0x0f, 
        0x0c, 0x07, 0x0f, 0x02, 
        0x04, 0x01, 0x04, 0x05, 
        //	A
        0x00, 0x0e, 0x0d, 0x02, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x0f, 
        0x04, 0x01, 0x00, 0x05, 
        //	C
        0x00, 0x0e, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x0b, 0x00, 0x0a, 
        0x00, 0x04, 0x05, 0x01, 
        //	K
        0x0c, 0x03, 0x08, 0x07, 
        0x0c, 0x0b, 0x07, 0x00, 
        0x0c, 0x03, 0x0d, 0x02, 
        0x04, 0x01, 0x00, 0x05, 
        //	Y
        0x0c, 0x03, 0x0c, 0x03, 
        0x04, 0x0b, 0x0e, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
   };

    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + (32 - 6 * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 - VramRowSize * 4 * VramStep;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9 * VramStep, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2023");
}