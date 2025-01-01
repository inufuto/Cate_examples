#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

constexpr byte Char_Remain = Char_Man;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}

void PrintStatus() 
{
    PrintS(Vram[1].chars + 64, "SCORE");
    PrintS(Vram[6].chars + 64, "HI-SCORE");
    PrintS(Vram[11].chars + 64, "STAGE");
    PrintByteNumber2(Vram[11].chars + 76, CurrentStage + 1);
    {
        ptr<byte> pVram = Vram[21].chars + 66;
        if (RemainCount > 1) {
            byte i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = PrintC(pVram, 0x20);
                pVram = PrintC(pVram, i + 0x30);
            }
            else {
                do {
                    Put2C(pVram, Char_Remain);
                    pVram += 2 * VramStep;
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
    ptr<byte> pVram = PrintNumber5(Vram[3].chars + 68, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram[8].chars + 68, HiScore);
    PrintC(pVram, '0');
}

void PrintFoodCount()
{
    ptr<byte> pVram = Vram[18].chars + 66;
    pVram = Put2C(pVram, Char_Food) + VramStep;
    PrintC(pVram, FoodCount + '0');
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    ptr<byte> pVVram;

    pVVram = VVramFront + VVramWidth * 9 + 10;
    repeat (height) {
        repeat (width) {
            *pVVram = Char_Space;
            ++pVVram;
        }
        pVVram += VVramWidth - width;
    }
    VVramToVram();
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram[11].chars + 24, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram[11].chars + 26, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
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
        ptr<byte> pVVram = VVramFront + VVramWidth * 7 + (32 - LogoLength * 4) / 2;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    *pVVram = *p;
                    ++pVVram;
                    ++p;
                }
                pVVram += VVramWidth - 4;
            }
            pVVram += 4 - VVramWidth * 4;
        }
    }
    VVramToVram();
    PrintS(Vram[18].chars + 18, "PUSH SPACE KEY");
    PrintS(Vram[20].chars + 18, "OR GRPH KEY");
    PrintS(Vram[23].chars + 40, "INUFUTO 2025");
}
