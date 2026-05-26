#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

extern void _deb();

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
        vram = Vram + VramRowSize * 23 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put2C(vram, Char_Remain);
                Erase2(vram);
                vram = PrintC(vram, Char_Space);
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
}


void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 3 + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 8 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
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
            0x0e, 0x05, 0x0b, 0x00, 
            0x0d, 0x0a, 0x02, 0x0c, 
            0x0a, 0x00, 0x0f, 0x04, 
            0x04, 0x05, 0x01, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x0f, 0x0c, 0x07, 
            0x0b, 0x07, 0x0c, 0x07, 
            0x04, 0x00, 0x04, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x01, 0x0f, 0x00, 0x0c, 
            0x01, 0x0f, 0x00, 0x0c, 
            0x01, 0x05, 0x05, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x00, 0x0e, 0x0d, 
            0x03, 0x00, 0x0f, 0x0e, 
            0x05, 0x01, 0x05, 0x04, 
            0x00, 0x0e, 0x05, 0x0b, 
            0x02, 0x0d, 0x0a, 0x02, 
            0x03, 0x0a, 0x00, 0x0f, 
            0x01, 0x04, 0x05, 0x01, 
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
    VVramToVram();
    PrintS(Vram + VramRowSize * 17 + 9 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 19 + 9 * VramStep, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 21 + 20 * VramStep, "INUFUTO 2025");
}
