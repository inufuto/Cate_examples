#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

void PrintStatus()
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 16 * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight + 18 * VramStep, CurrentStage + 1);
    PrintS(Vram + 22 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2 * VramStep;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = PrintC(vram, i + '0');
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    Put2C(vram, Char_Remain);
                    vram += 2 * VramStep;
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
    word address;
    
    address = PrintNumber5(Vram + AsciiRowHeight, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + AsciiRowHeight + 9 * VramStep, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + AsciiRowHeight + 23 * VramStep, StageTime);
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

void PrintPerfect()
{
    PrintS(Vram + VramRowSize * 12 + 12 * VramStep, "PERFECT!");
    DrawAll();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	H
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x0b, 0x0a, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
            //	O
            0x08, 0x07, 0x05, 0x0b, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x00, 0x05, 0x05, 0x01, 
            //	P
            0x0c, 0x07, 0x05, 0x0b, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x07, 0x05, 0x01, 
            0x04, 0x01, 0x00, 0x00, 
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
            //	N
            0x0c, 0x0b, 0x00, 0x0f, 
            0x0c, 0x0f, 0x0b, 0x0f, 
            0x0c, 0x03, 0x0d, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
        };
        constexpr byte LogoLength = 6;
        word vram = Vram + VramRowSize * 7 + (32 - LogoLength * 4) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
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
    PrintS(Vram + AsciiRowHeight * 13 + 11 * VramStep, "S:START");
    PrintS(Vram + AsciiRowHeight * 14 + 11 * VramStep, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 16 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram + VramRowSize * 3;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - CharWidth * 16;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}