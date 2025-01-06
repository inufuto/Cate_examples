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
    PrintS(Vram + 13, true, "STAGE");
    PrintByteNumber3(Vram + 16, false, CurrentStage + 1);

    {
        word vram;
        vram = Vram + 21;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put(vram, Char_Remain);
                ++vram;
                Locate(vram, false);
                PrintC(' ');
                PrintC(i + '0');
            }
            else {
                do {
                    Put(vram, Char_Remain);
                    ++vram;
                    --i;
                } while (i > 0);
            }
        }
    }

    PrintScore();
    PrintFoodCount();
}

void PrintScore()
{
    PrintNumber5(Vram + 2, true, Score);
    PrintC('0');

    PrintNumber5(Vram + 10, false, HiScore);
    PrintC('0');
}

void PrintFoodCount()
{
    PutShift(Vram + 19, 0, Char_FoodCount);
    Locate(Vram + 20, false);
    PrintC(FoodCount + '0');
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 10, false, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    // HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x0c, 0x0b, 0x08, 
            0x00, 0x0c, 0x07, 0x07, 
            0x00, 0x0c, 0x03, 0x00, 
            0x00, 0x04, 0x01, 0x00, 
            0x0f, 0x08, 0x02, 0x00, 
            0x0f, 0x08, 0x02, 0x0e, 
            0x0f, 0x0c, 0x03, 0x0f, 
            0x05, 0x04, 0x01, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x0d, 0x02, 0x0f, 0x0c, 
            0x05, 0x01, 0x04, 0x0d, 
            0x05, 0x00, 0x05, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x0e, 0x0d, 0x02, 
            0x03, 0x0f, 0x05, 0x01, 
            0x00, 0x04, 0x05, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0x0d, 0x02, 0x00, 
            0x0f, 0x0c, 0x03, 0x00, 
            0x05, 0x04, 0x01, 0x00, 
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