#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man_Left_Stop;

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
    ptr<byte> pVram;
    pVram = PrintByteNumber3(Vram + 24, StageTime);
    PrintC(pVram, ' ');
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
            pVram = PrintC(pVram, Char_Space);
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

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 11 + 10;
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
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12, "TIME UP");
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
        pVram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 16 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 18 + 9, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 22 + VramWidth - 12, "INUFUTO 2026");
    // {
    //     ptr<byte> pVram = Vram + VramRowSize * 2;
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
