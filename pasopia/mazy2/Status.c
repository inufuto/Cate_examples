#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

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
    PrintS(Vram + VramRowSize * 1 + 32 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 6 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 11 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 11 + 38 * VramStep, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 14 + 32 * VramStep, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 22 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(vram, Char_Remain);
                vram += 2 * VramStep;
                vram = PrintC(vram, ' ');
                vram = PrintC(vram, i + 0x30);
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
    PrintHeldKnives();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 3 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 8 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintHeldKnives()
{
    word vram = Vram + VramRowSize * 19 + 33 * VramStep;
    byte i = HeldKnifeCount;
    while (i != 0) {
        vram = Put(vram, Char_Knife) + 1;
        --i;
    }
    Put(vram, Char_Space);
}


void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 14 + 37 * VramStep, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    word vram;

    vram = Vram + VramWidth * 10 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            vram = Put(vram, Char_Space);
        }
        vram += VramWidth - width * 2;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 12 * VramStep, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 13 * VramStep, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
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
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + (32 - LogoLength * 4) / 2 * VramStep;
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
    PrintS(Vram + VramRowSize * 18 + 18, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 18, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 40, "INUFUTO 2025");
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
