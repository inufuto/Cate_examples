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
    PrintS(Vram + VramRowSize * 1 + 64, "SCORE");
    PrintS(Vram + VramRowSize * 6 + 64, "HI-SCORE");
    PrintS(Vram + VramRowSize * 11 + 64, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 11 + 76, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 14 + 64, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 22 + 66;
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
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 3 + 68, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 8 + 68, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 14 + 74, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    
    word vram;

    vram = Vram + VramWidth * 10 + 10 * 2;
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
    PrintS(Vram + VramRowSize * 11 + 24, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 11 + 26, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	C
        0x00, 0x0e, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x0b, 0x00, 0x0a, 
        0x00, 0x04, 0x05, 0x01, 
        //	R
        0x0c, 0x07, 0x05, 0x0b, 
        0x0c, 0x03, 0x08, 0x0f, 
        0x0c, 0x07, 0x0f, 0x02, 
        0x04, 0x01, 0x04, 0x05, 
        //	A
        0x00, 0x0e, 0x0d, 0x02, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x0f, 
        0x04, 0x01, 0x00, 0x05, 
        //	C
        0x00, 0x0e, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x0b, 0x00, 0x0a, 
        0x00, 0x04, 0x05, 0x01, 
        //	K
        0x0c, 0x03, 0x08, 0x07, 
        0x0c, 0x0b, 0x07, 0x00, 
        0x0c, 0x03, 0x0d, 0x02, 
        0x04, 0x01, 0x00, 0x05, 
        //	Y
        0x0c, 0x03, 0x0c, 0x03, 
        0x04, 0x0b, 0x0e, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
   };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 7 + 4 * 2;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramWidth - 4 * 2;
            }
            vram += 4 * 2 - VramWidth * 4;
        }
    }
    PrintS(Vram + VramRowSize * 18 + 18, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 18, "OR GRPH KEY");
    PrintS(Vram + VramRowSize * 23 + 40, "INUFUTO 2023");
}
