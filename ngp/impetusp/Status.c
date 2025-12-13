#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "CopyMemory.h"
                            #include "Fort.h"

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
    PrintS(VramFront + 1 * VramStep, "SCORE");
    PrintS(VramFront + 7 * VramStep, "STAGE");

    PrintScore();
    PrintStage();
    PrintRemain();
}

void PrintScore()
{
    word vram = PrintNumber5(VramFront + VramRowSize, Score);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(VramFront + VramRowSize + 10 * VramStep, CurrentStage + 1);
}

void PrintRemain()
{
    word vram = VramFront + 15 * VramStep;
    if (RemainCount > 1) {
        byte i = RemainCount - 1;
        if (i > 5) {
            vram = Put(vram, Char_Remain);
            vram = Put(vram, i + 0x02);
            i -= 2;
            while (i != 0) {
                vram = Put(vram, Char_Space);
                --i;
            }
        }
        else {
            do {
                vram = Put(vram, Char_Remain);
                --i;
            } while (i != 0);
        }
    }
    vram = Put(vram, Char_Space);
}

void PrintGameOver()
{
    PrintS(VramFront + VramRowSize * 9 + (20 - 9) / 2 * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x29, 0x23, 0x00, 0x00, 
            0x28, 0x1f, 0x28, 0x1e, 
            0x28, 0x1f, 0x28, 0x2b, 
            0x21, 0x21, 0x20, 0x1d, 
            0x00, 0x00, 0x00, 0x00, 
            0x2a, 0x28, 0x23, 0x27, 
            0x2b, 0x28, 0x27, 0x23, 
            0x21, 0x20, 0x1d, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x28, 0x23, 0x1d, 0x29, 
            0x28, 0x23, 0x1d, 0x28, 
            0x20, 0x21, 0x1d, 0x20, 
            0x00, 0x00, 0x00, 0x00, 
            0x23, 0x28, 0x1f, 0x2b, 
            0x1f, 0x28, 0x1f, 0x2b, 
            0x1d, 0x00, 0x21, 0x1d, 
            0x00, 0x00, 0x00, 0x1e, 
            0x24, 0x23, 0x20, 0x23, 
            0x20, 0x29, 0x1e, 0x00, 
            0x20, 0x21, 0x00, 0x00, 
        };
        constexpr byte LogoLength = 5;
        word vram = VramBack + VramRowSize * 5 + (20 - 4 * LogoLength) / 2 * VramStep;
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
        PrintS(VramBack + VramRowSize * 9 + 15 * VramStep, "MICRO");
    }
    PrintS(VramBack + VramRowSize * 15 + 5 * VramStep, "A:START");
    PrintS(VramBack + VramRowSize * 16 + 5 * VramStep, "B:CONTINUE");
    PrintS(VramBack + VramRowSize * 18 + 8 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = VramBack + VramRowSize * 2;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // {
    //     FortCharOffset = 0;
    //     FortDotOffset = 0;
    //     UpdateFortChars();
    //     FortCharOffset = 42;
    //     FortDotOffset = 3;
    //     UpdateFortChars();
    //     word vram = VramBack + VramRowSize * 2 + 14 * VramStep;
    //     byte c = Char_Fort;
    //     repeat (7 * 2) {
    //         repeat (6) {
    //             vram = Put(vram, c);
    //             ++c;
    //         }
    //         vram += VramRowSize - 6 * VramStep;
    //     }
    // }
}