#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 7, "HI-SCORE");
    PrintS(Vram + 16, "STAGE");
    PrintByteNumber2(Vram + VramRowSize + 18, CurrentStage + 1);
    PrintS(Vram+ 22, "TIME");

    {
        static const byte[] RemainChars = {
            Char_MyFort + 2, 
            Char_MyFort + 3,
            Char_MyFort + 6,
            Char_MyFort + 7,
        };
        ptr<byte> pVram;
        pVram = Vram + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                ptr<byte> pChars;
                pChars = RemainChars;
                repeat (2) {
                    repeat (2) {
                        VPut(pVram, *pChars);
                        ++pVram;
                        ++pChars;
                    }
                    pVram += VramRowSize - 2;
                }
                pVram += 2 - VramRowSize * 2;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9, HiScore);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize + 23, StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 11 + 10;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 12, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	B
        0x0c, 0x07, 0x05, 0x0b, 
        0x0c, 0x0b, 0x0a, 0x07, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x04, 0x05, 0x05, 0x01, 
        //	A
        0x00, 0x0e, 0x0d, 0x02, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x0f, 
        0x04, 0x01, 0x00, 0x05, 
        //	T
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
        //	T
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
        //	L
        0x0c, 0x03, 0x00, 0x00, 
        0x0c, 0x03, 0x00, 0x00, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
        //	O
        0x08, 0x07, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x00, 0x05, 0x05, 0x01, 
        //	T
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x04, 0x01, 0x00, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + 2;
        p = TitleBytes;
        repeat (7) {
            repeat (4) {
                repeat (4) {
                    VPut(pVram, *p);
                    ++pVram;
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR SHIFT KEY");
}