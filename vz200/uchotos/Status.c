#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Movable.h"
#include "Actor.h"
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
    PrintS(Vram + 0, "SC");
    PrintS(Vram + 9, "HI");
    PrintS(Vram + 18, "ST");
    PrintByteNumber2(Vram + 20, CurrentStage + 1);
    PrintS(Vram+ 23, "T");
    PrintScore();
    PrintTime();
    PrintRemain();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram + 2 * VramStep , Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram + 11 * VramStep, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + 24, StageTime);
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = Vram + 28 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            Put2C(pVram, Char_Remain);
            pVram += 2 * VramStep;
            pVram = PrintC(pVram, ' ');
            pVram = PrintC(pVram, i + 0x30);
        }
        else {
            do {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                --i;
            } while (i > 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(pVram);
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize6 * 6 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize6 * 6 + 12, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x0f, 0x00, 0x0f, 0x00, 
            0x0f, 0x00, 0x0f, 0x08, 
            0x0f, 0x00, 0x0f, 0x0c, 
            0x04, 0x05, 0x01, 0x00, 
            0x00, 0x00, 0x0c, 0x03, 
            0x07, 0x0b, 0x0c, 0x07, 
            0x03, 0x0a, 0x04, 0x01, 
            0x05, 0x01, 0x00, 0x00, 
            0x0f, 0x00, 0x00, 0x04, 
            0x0f, 0x08, 0x07, 0x0b, 
            0x05, 0x0c, 0x03, 0x0f, 
            0x00, 0x00, 0x05, 0x01, 
            0x0d, 0x07, 0x01, 0x00, 
            0x0c, 0x03, 0x0e, 0x0d, 
            0x04, 0x01, 0x0f, 0x0c, 
            0x00, 0x00, 0x04, 0x05, 
            0x00, 0x0e, 0x05, 0x01, 
            0x02, 0x04, 0x0d, 0x03, 
            0x03, 0x05, 0x05, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize5 * 3 + (VramWidth - LogoLength * 4) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (2) {
                repeat (4) {
                    pVram = Put3(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize3 - 4;
                repeat (4) {
                    pVram = Put2(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize2 - 4;
            }
            pVram += 4 - VramWidth * 10;
        }
    }
    PrintS(Vram + VramRowSize6 * 7 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize6 * 8 + 9, "OR SHIFT KEY");
    PrintS(Vram + VramWidth * 58 + VramWidth - 12, "INUFUTO 2026");
    // {
    //     byte c;
    //     word v;
    //     ptr<byte> pVram;
    //     pVram = Vram;
    //     c = 0x0;
    //     repeat (20) {
    //         Put(pVram, c);
    //         ++pVram;
    //         ++c;
    //     }
    // }
}
