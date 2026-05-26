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

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 24, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 26, "TIME UP");
}

void PrintPerfect() 
{
    PrintS(Vram + VramRowSize * 11 + 26, "PERFECT!");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	H
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x0b, 0x0a, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
            //	O
            0x08, 0x07, 0x05, 0x0b, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x00, 0x05, 0x05, 0x01, 
            //	P
            0x0c, 0x07, 0x05, 0x0b, 
            0x0c, 0x03, 0x00, 0x0f, 
            0x0c, 0x07, 0x05, 0x01, 
            0x04, 0x01, 0x00, 0x00, 
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
            //	N
            0x0c, 0x0b, 0x00, 0x0f, 
            0x0c, 0x0f, 0x0b, 0x0f, 
            0x0c, 0x03, 0x0d, 0x0f, 
            0x04, 0x01, 0x00, 0x05, 
        };
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
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
