#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Movable.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Man_Left_Stop;

void PrintS(byte x, byte y, ptr<byte> p)
{
    byte c;
    Locate(x, y);
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
    Locate(18, 1);
    PrintByteNumber2(CurrentStage + 1);
    PrintS(22, 0, "TIME");

    {
        byte x, y;
        x = 27;
        y = 0;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                Put2(x, y, Char_Remain);
                x += 2;
                Erase2(x, y);
                Locate(x, y + 1);
                Put(i + 0x10);
            }
            else {
                do {
                    Put2(x, y, Char_Remain);
                    x += 2;
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
    Locate(0, 1);
    PrintNumber5(Score);
    PrintC('0');

    Locate(9, 1);
    PrintNumber5(HiScore);
    PrintC('0');
}

void PrintTime()
{
    Locate(23, 1);
    PrintByteNumber3(StageTime);
}

void PrintGameOver()
{
    PrintS(11, 12, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(12, 12, "TIME UP");
}

void PrintPerfect() 
{
    PrintS(12, 12, "PERFECT!");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        static const byte[] TitleBytes = {
            //	H
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x4b, 0x4a, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	O
            0x48, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	P
            0x4c, 0x47, 0x45, 0x4b, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x41, 
            0x44, 0x41, 0x40, 0x40, 
            //	M
            0x4c, 0x47, 0x47, 0x4b, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x4c, 0x43, 0x43, 0x4f, 
            0x44, 0x41, 0x41, 0x45, 
            //	A
            0x40, 0x4e, 0x4d, 0x42, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x47, 0x45, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	N
            0x4c, 0x4b, 0x40, 0x4f, 
            0x4c, 0x4f, 0x4b, 0x4f, 
            0x4c, 0x43, 0x4d, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
        };
        ptr<byte> p;
        byte x, y;
        x = 4;
        y = 7;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                Locate(x, y);
                repeat (4) {
                    Put(*p);
                    ++p;
                }
                ++y;
            }
            y -= 4;
            x += 4;
        }
    }
    PrintS(7, 19, "PUSH TRIGGER BUTTON");
    PrintS(20, 22, "INUFUTO 2023");
}