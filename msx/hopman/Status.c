#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramWidth + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    {
        word vram;
        vram = Vram + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramWidth - 2;
                vram = Put(vram, i + 0x10);
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    Put2C(vram, Char_Remain);
                    vram += 2;
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
    
    address = PrintNumber5(Vram + VramWidth, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramWidth + 9, HiScore);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramWidth + 23, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp()
{
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void PrintPerfect()
{
    PrintS(Vram + VramWidth * 12 + 12, "PERFECT!");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	H
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x4b, 0x4a, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	O
            0x48, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	P
            0x4c, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x41, 
            0x44, 0x41, 0x40, 0x40, 
            //	M
            0x4c, 0x47, 0x47, 0x4b, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x44, 0x41, 0x41, 0x45, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	N
            0x4c, 0x4b, 0x40, 0x4f, 
            0x4c, 0x4f, 0x4b, 0x4f, 
            0x4c, 0x43, 0x4d, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + (VramWidth - LogoLength * 4) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramWidth - 4;
            }
            vram += 4 - VramWidth * 4;
        }
    }
    PrintS(Vram + VramWidth * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 20 + 9, "OR GRPH KEY");
    PrintS(Vram + VramWidth * 23 + 20, "INUFUTO 2023");

    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16;
    //         }
    //     }
    // }
}