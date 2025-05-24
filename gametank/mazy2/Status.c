#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus()
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");
    {
        word vram = Vram + 29 * VramStep;
        if (RemainCount > 1) {
            vram = Put2C(vram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                // vram += VramRowSize;
                vram = PrintC(vram, i + '0');
            }
        }
    }
    Put(Vram + 27 * VramStep, Char_Knife);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    {
        word vram = PrintNumber5(Vram + AsciiRowHeight, Score);
        PrintC(vram, '0');
    }
    {
        word vram = PrintNumber5(Vram + AsciiRowHeight + 9 * VramStep, HiScore);
        PrintC(vram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + AsciiRowHeight + 23 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(Vram + AsciiRowHeight + 27 * VramStep, HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
    DrawAll();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "TIME UP");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    DrawAll();
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
        word vram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + AsciiRowHeight * 12 + 11 * VramStep, "S:START");
    PrintS(Vram + AsciiRowHeight * 13 + 11 * VramStep, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 15 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}