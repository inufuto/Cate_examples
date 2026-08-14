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
    PrintS(Vram[14].chars + 64, "TIME");
    PrintScore();
    PrintTime();
    PrintRemain();
}

void PrintScore()
{
    {
        ptr<byte> pVram = PrintNumber5(Vram[3].chars + 68, Score);
        PrintC(pVram, '0');
    }
    {
        ptr<byte> pVram = PrintNumber5(Vram[8].chars + 68, HiScore);
        PrintC(pVram, '0');
    }
}

void PrintTime()
{
    PrintByteNumber3(Vram[14].chars + 74, StageTime);
}

void PrintRemain()
{
    {
        ptr<byte> pVram;
        pVram = Vram[22].chars + 66;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2C(pVram, Char_Remain);
                pVram += 2 * VramStep;
                pVram = PrintC(pVram, Char_Space);
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
        if (RemainCount < 3) {
           Erase2(pVram);
        }
    }
    // {
    //     ptr<VramAttr> pAttr;
    //     pAttr = Vram[24].attrs;
    //     pAttr[0].column = 0;
    //     pAttr[0].attr = 0xf8;
    //     pAttr[1].column = 64;
    //     pAttr[1].attr = 0xb8;
    // }
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    ptr<byte> pVVram;

    pVVram = VVramFront + VVramWidth * 9 + 10;
    repeat (height) {
        repeat (width) {
            *pVVram = Char_White;
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
            0x0f, 0x00, 0x0f, 0x00, 
            0x0f, 0x00, 0x0f, 0x08, 
            0x0f, 0x00, 0x0f, 0x0c, 
            0x04, 0x05, 0x01, 0x00, 
            0x00, 0x00, 0x0c, 0x03, 
            0x07, 0x0b, 0x0c, 0x07, 
            0x03, 0x0a, 0x04, 0x01, 
            0x05, 0x01, 0x00, 0x00, 
            0x0f, 0x00, 0x00, 0x04, 
            0x0f, 0x08, 0x07, 0x0b, 
            0x05, 0x0c, 0x03, 0x0f, 
            0x00, 0x00, 0x05, 0x01, 
            0x0d, 0x07, 0x01, 0x00, 
            0x0c, 0x03, 0x0e, 0x0d, 
            0x04, 0x01, 0x0f, 0x0c, 
            0x00, 0x00, 0x04, 0x05, 
            0x00, 0x0e, 0x05, 0x01, 
            0x02, 0x04, 0x0d, 0x03, 
            0x03, 0x05, 0x05, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
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
    PrintS(Vram[23].chars + 40, "INUFUTO 2026");
}
