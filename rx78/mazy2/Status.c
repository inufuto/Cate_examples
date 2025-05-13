#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

void PrintStatus() 
{
    PrintS(Vram + 0, false, "SCORE");
    PrintS(Vram + 6, false, "HI-SCORE");
    PrintS(Vram + 13, true, "ST");
    PrintByteNumber2(Vram + 14, true, CurrentStage + 1);
    PrintS(Vram + 16, false, "TIME");
    {
        word vram;
        vram = Vram + 22;
        if (RemainCount > 1) {
            Put(vram, Char_Remain); ++vram;
            byte i = RemainCount - 1;
            if (i > 1) {
                Locate(vram, false);
                PrintC(i + '0');
            }
        }
    }
    Put(Vram + 20, Char_Knife);
    PrintScore();
    PrintTime();
}

void PrintScore()
{
    PrintNumber5(Vram + 2, true, Score);
    PrintC('0');

    PrintNumber5(Vram + 10, false, HiScore);
    PrintC('0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + 18, false, StageTime);
    PrintC(' ');
}

void PrintHeldKnives()
{
    Locate(Vram + 21, false);
    PrintC(HeldKnifeCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 10, false, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 12 + 10, false, " TIME UP");
}

void Title()
{
    ClearScreen(); 
    // HideAllSprites();
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
        constexpr byte left = (32 - LogoLength * 4) / 2;
        ptr<byte> p;
        word vram;
        byte xMod;

        vram = Vram + VramRowSize * 7 + left * 3 / 4;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                xMod = left & 3;
                repeat (4) {
                    PutShift(vram, xMod, *p);
                    ++p;
                    xMod += 6;
                    if (xMod >= 8) {
                        xMod -= 8;
                        ++vram;
                    }
                }
                vram += VramRowSize - 3;
            }
            vram += 3 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, false, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, false, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 22 + 18, false, "INUFUTO 2025");
}