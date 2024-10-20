#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    // PrintS(Vram + 7 * VramStep, "HI-SCORE");
    PrintS(Vram + 7 * VramStep, "ST");
    PrintByteNumber2(Vram + VramRowSize + 7 * VramStep, CurrentStage + 1);
    PrintS(Vram+ 10 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + 15 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2 * VramStep;
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = Put(vram, i + 0x10);
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
    address = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(address, '0');
    // address = PrintNumber5(Vram + VramRowSize + 9 * VramStep, HiScore);
    // PrintC(address, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 11 * VramStep, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 7 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 7 + (20 - 7) / 2 * VramStep, "TIME UP");
}

void PrintPerfect() 
{
    PrintS(Vram + VramRowSize * 7 + (20 - 7) / 2 * VramStep, "PERFECT!");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    HScroll = 0;
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x40, 0x4f, 0x4c, 0x43, 
            0x40, 0x4f, 0x4e, 0x43, 
            0x40, 0x4f, 0x4c, 0x43, 
            0x40, 0x45, 0x44, 0x41, 
            0x4e, 0x4d, 0x42, 0x4f, 
            0x4f, 0x4c, 0x43, 0x4f, 
            0x4f, 0x4c, 0x43, 0x4f, 
            0x44, 0x45, 0x40, 0x45, 
            0x4d, 0x42, 0x4b, 0x48, 
            0x4e, 0x41, 0x4f, 0x4f, 
            0x40, 0x40, 0x4f, 0x4c, 
            0x40, 0x40, 0x45, 0x44, 
            0x43, 0x4e, 0x4d, 0x42, 
            0x43, 0x4f, 0x4e, 0x43, 
            0x43, 0x4f, 0x4c, 0x43, 
            0x41, 0x45, 0x44, 0x41, 
            0x4f, 0x4d, 0x42, 0x40, 
            0x4f, 0x4c, 0x43, 0x40, 
            0x4f, 0x4c, 0x43, 0x40, 
            0x45, 0x44, 0x41, 0x40, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 4 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(Vram + VramRowSize * 10 + ((20 + 4 * LogoLength) / 2 - 4) * VramStep, "MINI");
    }
    PrintS(Vram + VramRowSize * 14 + 1 * VramStep, "PUSH START BUTTON");
    PrintS(Vram + VramRowSize * 16 + 8 * VramStep, "INUFUTO 2024");
    // {
    //     word vram;
    //     byte c;
    //     HScroll = 48;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}