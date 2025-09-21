#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Rader.h"

constexpr byte Char_Remain = Char_Fighter;

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
    PrintS(Vram + 48, "SCORE");
    PrintS(Vram + VramRowSize * 1 + 48, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 1 + 58, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + 54, Score);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram = Vram + VramRowSize * 8 + 48;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            PrintC(pVram + VramRowSize, RemainCount + ('0' - 1));
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i > 0);
        }
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (16 * VramStep - 9) / 2, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (16 * VramStep - 7) / 2, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x0f, 0x09, 0x0c, 
            0x00, 0x0f, 0x06, 0x0c, 
            0x00, 0x0f, 0x0c, 0x0c, 
            0x00, 0x05, 0x04, 0x00, 
            0x03, 0x03, 0x0f, 0x09, 
            0x03, 0x03, 0x0f, 0x0c, 
            0x03, 0x03, 0x0f, 0x01, 
            0x05, 0x00, 0x05, 0x00, 
            0x04, 0x0f, 0x01, 0x0f, 
            0x00, 0x0f, 0x00, 0x0f, 
            0x00, 0x0f, 0x00, 0x0f, 
            0x00, 0x05, 0x00, 0x04, 
            0x0c, 0x08, 0x07, 0x02, 
            0x0c, 0x04, 0x0b, 0x00, 
            0x0c, 0x08, 0x02, 0x03, 
            0x01, 0x00, 0x05, 0x00, 
        };
        constexpr byte LogoLength = 4;
        constexpr byte LogoLeft = 0;
        ptr<byte> pVram = Vram + VramRowSize * 5 + LogoLeft;
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
        PrintS(Vram + VramRowSize * 9 + LogoLeft + 4 * LogoLength * VramStep - 4, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 13, "PUSH SPACE KEY OR ENTER KEY");
    PrintS(Vram + VramRowSize * 15 + 48 - 12, "INUFUTO 2025");
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
