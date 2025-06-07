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
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram + 10 * VramStep, "TIME");
    if (RemainCount > 0) {
        if (RemainCount > 1) {
            Put2C(Vram + 17 * VramStep, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                PrintC(Vram + VramRowSize + 18 * VramStep, i + '0');
            }
        }
    }
    Put(Vram + 15 * VramStep, Char_Knife, 0);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    ptr<byte> pVram = PrintNumber5(Vram + VramRowSize + 0 * VramStep, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + VramRowSize + 15 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 4 + (18 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 4 + (18 - 7) / 2 * VramStep, "TIME UP");
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
        ptr<byte> p = TitleBytes;
        constexpr byte LogoLeft = (WindowWidth - 4 * LogoLength) / 2;
        ptr<byte> pVram = Vram + VramRowSize * 2 + LogoLeft * VramStep;
        repeat (LogoLength) {
            byte shift;
            shift = 3;
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p, shift);
                    ++p;
                }
                pVram -= 4 * CharWidth;
                shift += 3;
                if (shift >= 8) {
                    shift -= 8;
                    pVram += VramRowSize;
                }
            }
            pVram += 4 * CharWidth - VramRowSize;
        }
        PrintS(Vram + VramRowSize * 4 + (LogoLeft + LogoLength * 4 - 4) * 3, "MINI");
    }
    PrintS(Vram + VramRowSize * 6 + 0 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 7 + 7 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentVram();
}