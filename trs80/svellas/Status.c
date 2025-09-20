#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"

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
    PrintByteNumber2(Vram + 7 * VramStep, CurrentStage + 1);
    {
        ptr<byte> pVram;
        pVram = Vram + 15 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                pVram = PrintC(pVram, Char_Space);
                pVram = PrintC(pVram, i + 0x30);
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
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
    ptr<byte> pVram = PrintNumber5(Vram, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + 10 * VramStep, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (20 - 7) / 2 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x0e, 0x05, 0x0b, 0x00, 
            0x0d, 0x0a, 0x02, 0x0c, 
            0x0a, 0x00, 0x0f, 0x04, 
            0x04, 0x05, 0x01, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x0f, 0x0c, 0x07, 
            0x0b, 0x07, 0x0c, 0x07, 
            0x04, 0x00, 0x04, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x01, 0x0f, 0x00, 0x0c, 
            0x01, 0x0f, 0x00, 0x0c, 
            0x01, 0x05, 0x05, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x00, 0x0e, 0x0d, 
            0x03, 0x00, 0x0f, 0x0e, 
            0x05, 0x01, 0x05, 0x04, 
            0x00, 0x0e, 0x05, 0x0b, 
            0x02, 0x0d, 0x0a, 0x02, 
            0x03, 0x0a, 0x00, 0x0f, 
            0x01, 0x04, 0x05, 0x01, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> pVram = Vram + VramRowSize * 2 + (20 - 4 * LogoLength) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
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
        PrintS(Vram + VramRowSize * 6 + 15 * VramStep, "MICRO");
    }
    PrintS(Vram + VramRowSize * 10 + 3 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 12 + 3 * VramStep, "OR ENTER KEY");
    PrintS(Vram + VramRowSize * 14 + 8 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0x0;
    //     repeat (20) {
    //         Put(pVram, c);
    //         ++pVram;
    //         ++c;
    //     }
    // }
}
