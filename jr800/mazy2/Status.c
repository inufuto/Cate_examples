#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
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
    PrintS(Vram + 0 * VramStep, "SC");   
    PrintS(Vram + 9 * VramStep, "ST");
    PrintByteNumber2(Vram + 11 * VramStep, CurrentStage + 1);
    PrintC(Vram + 14 * VramStep, 'T');
    {
        ptr<byte> pVram = Vram + 21 * VramStep;
        if (RemainCount > 1) {
            pVram = Put2C(pVram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                pVram = PrintC(pVram, i + '0');
            }
        }
    }
    PutU(Vram + 19 * VramStep, Char_Knife + 2);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + 2 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    ptr<byte> pVram = PrintByteNumber3(Vram + 15 * VramStep, StageTime);
    PrintC(pVram, ' ');
    PresentVram();
}

void PrintHeldKnives()
{
    PrintC(Vram + 20 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 4 + 8 * VramStep, "GAME OVER");
    PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 4 + 9 * VramStep, "TIME UP");
    PresentVram();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
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
            //	2
            0x08, 0x07, 0x05, 0x0b, 
            0x00, 0x08, 0x0e, 0x07, 
            0x08, 0x0f, 0x05, 0x00, 
            0x04, 0x05, 0x05, 0x05, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 1 + (VramWidth - LogoLength * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (2) {
                repeat (4) {
                    pVram = PutU(pVram, *p);
                    ++p;
                }
                pVram -= 4 * VramStep;
                repeat (4) {
                    pVram = PutL(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 2;
        }
        PrintS(Vram + VramRowSize * 3 + 18 * VramStep, "MINI");
    }

    PrintS(Vram + VramRowSize * 5 + 5 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 6 + 5 * VramStep, "OR RETURN KEY");
    PrintS(Vram + VramRowSize * 7 + 12 * VramStep, "INUFUTO 2025");

    PresentVram();
}