#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Fighter;

byte[VramRowSize * 2] Status;

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
    PrintS(Status + 1, "SCORE");
    PrintS(Status + 25, "STAGE");
    {
        ptr<byte> pVram = Status + 45;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2C(pVram, Char_Remain);
                Erase2(pVram);
                PrintC(pVram + VramRowSize, i + '0');
            }
            else {
                do {
                    pVram = Put2C(pVram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
        if (RemainCount < 3) {
            Erase2(pVram);
        }
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Status + VramRowSize, Score);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Status + VramRowSize + 27, CurrentStage + 1);
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (20 * VramStep - 9) / 2, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (20 * VramStep - 7) / 2, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    PrintStatus();
    StatusToVram();
    {
        static const byte[] TitleBytes = {
            0x0d, 0x07, 0x0c, 0x07, 
            0x0c, 0x03, 0x0c, 0x03, 
            0x0c, 0x03, 0x0c, 0x03, 
            0x05, 0x05, 0x04, 0x01, 
            0x07, 0x0b, 0x0c, 0x07, 
            0x03, 0x0f, 0x0c, 0x0b, 
            0x03, 0x0f, 0x0c, 0x03, 
            0x01, 0x05, 0x04, 0x01, 
            0x0b, 0x0c, 0x07, 0x01, 
            0x07, 0x0c, 0x0b, 0x02, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x05, 0x01, 
            0x0d, 0x07, 0x0c, 0x03, 
            0x0c, 0x03, 0x0c, 0x03, 
            0x0c, 0x03, 0x0c, 0x03, 
            0x04, 0x01, 0x00, 0x05, 
            0x0f, 0x08, 0x07, 0x0b, 
            0x0f, 0x04, 0x0b, 0x02, 
            0x0f, 0x08, 0x02, 0x0f, 
            0x01, 0x00, 0x05, 0x01, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> pVram = Vram + VramRowSize * 5 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 9 + + (20 + 4 * LogoLength) / 2 * VramStep - 4, "MINI");
    }
    PrintS(Vram + VramRowSize * 13 + 16, "PUSH SPACE KEY OR ENTER KEY");
    PrintS(Vram + VramRowSize * 15 + 60 - 11, "INUFUTO 2025");
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
