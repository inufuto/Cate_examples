#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Knife.h"

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
    PrintS(Vram + 54, "SCORE");
    PrintS(Vram + VramRowSize * 3 + 54, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 4 + 58, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 6 + 54, "TIME");
    if (RemainCount > 1) {
        ptr<byte> pVram = Vram + VramRowSize * 14 + 54;
        pVram = Put2C(pVram, Char_Remain);
        if (RemainCount > 2) {
            PrintC(pVram + VramRowSize, RemainCount + ('0' - 1));
        }
    }
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 54, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 7 + 57, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram = Vram + VramRowSize * 12 + 54;
    if (HeldKnifeCount > 0) {
        pVram = Put(pVram, Char_Kn_Up);
        PrintC(pVram, HeldKnifeCount + '0');
    }
    else {
        pVram = Put(pVram, Char_Space);
        PrintC(pVram, ' ');
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (18 * VramStep - 9) / 2, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (18 * VramStep - 7) / 2, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	M
            0x0c, 0x07, 0x07, 0x0b, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x04, 0x01, 0x01, 0x05, 
            //	A
            0x00, 0x0e, 0x0d, 0x02, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x07, 0x05, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
            //	Z
            0x04, 0x05, 0x0d, 0x07, 
            0x00, 0x08, 0x07, 0x00, 
            0x08, 0x07, 0x00, 0x00, 
            0x04, 0x05, 0x05, 0x05, 
            //	Y
            0x0c, 0x03, 0x0c, 0x03, 
            0x04, 0x0b, 0x0e, 0x01, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
        };
        constexpr byte LogoLength = 4;
        ptr<byte> pVram = Vram + VramRowSize * 5 + (18 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 9 + + (18 + 4 * LogoLength) / 2 * VramStep - 4, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 13, "PUSH SPACE KEY OR ENTER KEY");
    PrintS(Vram + VramRowSize * 15 + 54 - 11, "INUFUTO 2025");
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
