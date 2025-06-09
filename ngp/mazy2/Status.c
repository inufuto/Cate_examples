#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

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
    PrintS(VramFront + 1 * VramStep, "SCORE");
    PrintS(VramFront + 7 * VramStep, "ST");
    PrintByteNumber2(VramFront + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(VramFront+ 10 * VramStep, "TIME");
     {
        word vram = VramFront + 16 * VramStep;
        if (RemainCount > 1) {
            vram = Put2C(vram, Char_Remain);
            byte i = RemainCount - 1;
            if (i > 1) {
                vram += VramRowSize;
                vram = PrintC(vram, i + '0');
            }
        }
    }
    Put(VramFront + 15 * VramStep, Char_Knife);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    word address;
    address = PrintNumber5(VramFront + VramRowSize, Score);
    PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(VramFront + VramRowSize + 11 * VramStep, StageTime);
}

void PrintHeldKnives()
{
    PrintC(VramFront + VramRowSize + 15 * VramStep, HeldKnifeCount + '0');
}


void PrintGameOver()
{
    PrintS(VramFront + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(VramFront + VramRowSize * 7 + (20 - 7) / 2 * VramStep, "TIME UP");
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
            0x4c, 0x47, 0x47, 0x4b, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x44, 0x41, 0x41, 0x45, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	Z
            0x44, 0x45, 0x4d, 0x47, 
            0x40, 0x48, 0x47, 0x40, 
            0x48, 0x47, 0x40, 0x40, 
            0x44, 0x45, 0x45, 0x45, 
            //	Y
            0x4c, 0x43, 0x4c, 0x43, 
            0x44, 0x4b, 0x4e, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
            //	2
            0x48, 0x47, 0x45, 0x4b, 
            0x40, 0x48, 0x4e, 0x47, 
            0x48, 0x4f, 0x45, 0x40, 
            0x44, 0x45, 0x45, 0x45, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = VramBack + VramRowSize * 5 + (20 - 4 * LogoLength) / 2 * VramStep;
        p = TitleBytes;
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
    PrintS(VramBack + VramRowSize * 9 + 15 * VramStep, "MICRO");
    PrintS(VramBack + VramRowSize * 14 + 0 * VramStep, "PUSH TRIGGER BUTTON");
    PrintS(VramBack + VramRowSize * 16 + 8 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = VramFront + VramRowSize * 2 + 6 * VramStep;
    //     byte c = 0x00;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}