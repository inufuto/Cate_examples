#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"
#include "CopyMemory.h"


static void PrintS(byte x, byte y, ptr<byte> p)
{
    byte c;
    VLocate(x, y);
    while ((c = *p) != 0) {
        PrintC(c);
        ++p;
    }
}


static void PrintRemain(byte x)
{
    byte y, c;
    y = 0;
    c = Char_MyFighter;
    repeat (2) {
        repeat (2) {
            VLocate(x, y);
            VPut1(c);
            ++c;
            ++x;
        }
        x -= 2;
        ++y;
    }
}

void PrintStatus() 
{
    PrintS(1, 0, "SCORE");
    PrintS(8, 0, "HI-SCORE");
    PrintS(18, 0, "STAGE");

    {
        byte x;
        x = 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(x);
                VLocate(29, 0); VPut1(Char_Space);
                VLocate(30, 0); VPut1(Char_Space);
                VLocate(29, 1); VPut1(i + 0x10);
                VLocate(30, 1); VPut1(Char_Space);
            }
            else {
                do {
                    PrintRemain(x);
                    x += 2;
                    --i;
                } while (i > 0);
            }
        }
    }
    PrintScore();
    PrintStage();
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

void PrintStage()
{
    VLocate(20, 1);
    PrintByteNumber3(CurrentStage + 1);
}


void PrintGameOver()
{
    PrintS(11, 12, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(12, 12, "TIME UP");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	E
        0x4c, 0x47, 0x45, 0x41, 
        0x4c, 0x4b, 0x4a, 0x42, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	R
        0x4c, 0x47, 0x45, 0x4b, 
        0x4c, 0x43, 0x48, 0x4f, 
        0x4c, 0x47, 0x4f, 0x42, 
        0x44, 0x41, 0x44, 0x45, 
        //	I
        0x44, 0x4d, 0x47, 0x41, 
        0x40, 0x4c, 0x43, 0x40, 
        0x40, 0x4c, 0x43, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
        //	A
        0x40, 0x4e, 0x4d, 0x42, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x47, 0x45, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
        //	L
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x4c, 0x43, 0x40, 0x40, 
        0x44, 0x45, 0x45, 0x41, 
    };

    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        byte x, y;
        x = 4;
        y = 7;
        p = TitleBytes;
        repeat (6) {
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
    PrintS(19, 23, "INUFUTO 2021");
}