#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

void PrintS(byte x, byte y, ptr<byte> p)
{
    byte c;
    VLocate(x, y);
    while ((c = *p) != 0) {
        PrintC(c);
        ++p;
    }
}

void PrintStatus() 
{
    PrintS(1, 0, "SCORE"); 
    PrintS(7, 0, "HI-SCORE");
    PrintS(16, 0, "STAGE");
    VLocate(18, 1);
    PrintByteNumber2(CurrentStage + 1);
    PrintS(22, 0, "TIME");

    {
        static const byte[] RemainChars = {
            Char_MyFort + 2, 
            Char_MyFort + 3,
            Char_MyFort + 6,
            Char_MyFort + 7,
        };
        byte x, y;
        x = 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            do {
                ptr<byte> pChars;
                pChars = RemainChars;
                y = 0;
                repeat (2) {
                    VLocate(x, y);
                    repeat (2) {
                        VPut1(*pChars);
                        ++pChars;
                    }
                    ++y;
                }
                x += 2;
                --i;
            } while (i > 0);
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    VLocate(0, 1);
    PrintNumber5(Score);
    PrintC('0');

    VLocate(9, 1);
    PrintNumber5(HiScore);
    PrintC('0');
}

void PrintTime()
{
    VLocate(23, 1);
    PrintByteNumber3(StageTime);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    byte y;
    y = 11;
    repeat (height) {
        VLocate(10, y);
        repeat (width) {
            PrintC(' ');
        }
        ++y;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(11, 12, "GAME OVER");
}

void PrintTimeUp() 
{
    EraseWindow();
    PrintS(12, 12, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	B
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x4b, 0x4a, 0x47, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x44, 0x45, 0x45, 0x41, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	O
        0x48, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x40, 0x45, 0x45, 0x41, 
        //	T
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x44, 0x41, 0x40, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> p;
        byte x, y;
        x = 2;
        y = 7;
        p = TitleBytes;
        repeat (7) {
            repeat (4) {
                VLocate(x, y);
                repeat (4) {
                    VPut1(*p);
                    ++p;
                }
                ++y;
            }
            y -= 4;
            x += 4;
        }
    }
    PrintS(7, 19, "PUSH TRIGGER BUTTON");
}