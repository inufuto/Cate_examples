#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramWidth + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");
    {
        word vram = Vram + 27;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
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
    {
        word vram = PrintNumber5(Vram + VramWidth, Score);
        PrintC(vram, '0');
    }
    {
        word vram = PrintNumber5(Vram + VramWidth + 9, HiScore);
        PrintC(vram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramWidth + 23, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    

    word vram = Vram + VramWidth * 11 + 10;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 12, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x40, 0x48, 0x47, 0x4d, 
            0x40, 0x4c, 0x43, 0x4c, 
            0x40, 0x4c, 0x43, 0x4c, 
            0x40, 0x40, 0x45, 0x45, 
            0x42, 0x4e, 0x45, 0x41, 
            0x43, 0x44, 0x4d, 0x43, 
            0x43, 0x45, 0x45, 0x40, 
            0x40, 0x40, 0x40, 0x40, 
            0x40, 0x40, 0x44, 0x4d, 
            0x4e, 0x45, 0x4b, 0x4c, 
            0x4f, 0x40, 0x4f, 0x44, 
            0x44, 0x45, 0x41, 0x40, 
            0x47, 0x41, 0x40, 0x40, 
            0x43, 0x4e, 0x4d, 0x42, 
            0x41, 0x4f, 0x4c, 0x43, 
            0x40, 0x44, 0x45, 0x40, 
            0x4e, 0x45, 0x41, 0x40, 
            0x44, 0x4d, 0x43, 0x40, 
            0x45, 0x45, 0x40, 0x40, 
            0x40, 0x40, 0x40, 0x40, 
        };
        constexpr byte LogoLength = 5;
        ptr<byte> p = TitleBytes;
        word vram = Vram + VramWidth * 7 + (32 - LogoLength * 4) / 2;
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
    PrintS(Vram + VramWidth * 19 + 6, "PUSH TRIGGER BUTTON");
    PrintS(Vram + VramRowSize * 23 + 20 * VramStep, "INUFUTO 2024");
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
}