#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man;

static word PrintS(word vram, ptr<byte> p, bool right)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c, right);
        right = !right;
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(Vram + 0 / 2, "SC", false);   
    PrintS(Vram + 9 / 2, "ST", true);
    PrintByteNumber2(Vram + 11 / 2, CurrentStage + 1, true);
    PrintC(Vram + 14 / 2, 'T', false);
    {
        word vram = Vram + 21 / 2;
        if (RemainCount > 1) {
            vram = Put2C(vram, Char_Remain, true);
            byte i = RemainCount - 1;
            if (i > 1) {
                vram = PrintC(vram, i + '0', true);
            }
        }
    }
    Put(Vram + 19 / 2, Char_Knife + 2, true);
    PrintScore();
    PrintTime();
    PrintHeldKnives();
}

void PrintScore()
{
    word vram = PrintNumber5(Vram + 2 / 2, Score, false);
    PrintByteNumberC(vram, '0');
}

void PrintTime()
{
    word vram = PrintByteNumber3(Vram + 15 / 2, StageTime, true);
    PrintByteNumberC(vram, ' ');
    // PresentVram();
}

void PrintHeldKnives()
{
    PrintC(Vram + 20 / 2, HeldKnifeCount + '0', false);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 4 + 8 / 2, "GAME OVER", false);
    // PresentVram();
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 4 + 9 / 2, "TIME UP", true);
    // PresentVram();
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
        word vram = Vram + VramRowSize * 2 + (32 - LogoLength * 4) / 8;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                bool right;
                right = false;
                repeat (4) {
                    vram = Put(vram, *p, right);
                    right = !right;
                    ++p;
                }
                vram += VramRowSize - 2;
            }
            vram += 2 - VramRowSize * 4;
        }
        PrintS(Vram + VramRowSize * 6 + 18 / 2, "MINI", false);
    }
    PrintS(Vram + VramRowSize * 10 + 2, "PUSH SPACE KEY", false);
    PrintS(Vram + VramRowSize * 12 + 2, "OR RETURN KEY", false);
    PrintS(Vram + VramRowSize * 14 + 6, "INUFUTO 2025", false);

    // PresentVram();
}