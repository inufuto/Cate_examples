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

    {
        ptr<byte> pVram;
        pVram = Vram[21].chars + 66;
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
    }
    {
        ptr<VramAttr> pAttr;
        pAttr = Vram[24].attrs;
        pAttr[0].column = 0;
        pAttr[0].attr = 0xf8;
        pAttr[1].column = 64;
        pAttr[1].attr = 0xb8;
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram[3].chars + 68, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram[8].chars + 68, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram[14].chars + 74, StageTime);
}

void PrintHeldKnives()
{
    ptr<byte> pVram = Vram[19].chars + 66;
    byte i = HeldKnifeCount;
    while (i != 0) {
        pVram = Put(pVram, Char_Knife) + 1;
        --i;
    }
    Put(pVram, Char_Space);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    ptr<byte> pVVram;

    pVVram = VVramFront + VVramWidth * 9 + 10;
    repeat (height) {
        repeat (width) {
            *pVVram = Char_Space2;
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
        ptr<byte> p = TitleBytes;
        ptr<byte> pVram = Vram[7].chars + (32 - LogoLength * 4) / 2 * VramStep;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
        ptr<VramAttr> pAttr = Vram[7].attrs;
        repeat (4) {
            pAttr[0].attr = 0xb8;
            pAttr[1].column = 64;
            pAttr += VramRowSize / 2;
        }
    }
    PrintS(Vram[18].chars + 18, "PUSH SPACE KEY");
    PrintS(Vram[20].chars + 18, "OR GRPH KEY");
    PrintS(Vram[23].chars + 40, "INUFUTO 2025");
}
