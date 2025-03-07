#include "Status.h"
#include "Vram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"

constexpr byte Char_Remain = Char_Fighter;

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
    PrintS(WindowWidth, 0, "SCORE");
    PrintS(WindowWidth, 3, "HIGH");
    PrintS(WindowWidth, 4, "SCORE");
    PrintS(WindowWidth, 7, "STAGE");
    Locate(WindowWidth + 4, 8); PrintByteNumber2(CurrentStage + 1);
    PrintRemain();
    PrintScore();
}

void PrintScore()
{
    Locate(WindowWidth, 1);
    PrintNumber5(Score);
    PrintC('0');

    Locate(WindowWidth, 5);
    PrintNumber5(HiScore);
    PrintC('0');
}

void PrintRemain()
{
    constexpr byte Y = 21;
    byte x;
    x = WindowWidth + 1;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            Put2C(x, Y, Char_Remain); 
            x += 2;
            Erase2(x, Y);
            Locate(x, Y + 1); PrintC(i + '0');
            x += 2;
        }
        else {
            do {
                Put2C(x, Y, Char_Remain); 
                x += 2;
                --i;
            } while (i > 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(x, Y);
    }
}


void PrintGameOver()
{
    constexpr byte X = (WindowWidth - 9) / 2;
    constexpr byte Y = WindowHeight / 2;
    PrintS(X, Y, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            //	G
            0x40, 0x4e, 0x45, 0x4b, 
            0x4c, 0x43, 0x4a, 0x4a, 
            0x44, 0x4b, 0x40, 0x4f, 
            0x40, 0x44, 0x45, 0x45, 
            //	U
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	N
            0x4c, 0x4b, 0x40, 0x4f, 
            0x4c, 0x4f, 0x4b, 0x4f, 
            0x4c, 0x43, 0x4d, 0x4f, 
            0x44, 0x41, 0x40, 0x45, 
            //	T
            0x44, 0x4d, 0x47, 0x41, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x4c, 0x43, 0x40, 
            0x40, 0x44, 0x41, 0x40, 
            //	U
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x4c, 0x43, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
            //	S
            0x48, 0x47, 0x45, 0x4b, 
            0x44, 0x4b, 0x4a, 0x42, 
            0x48, 0x42, 0x40, 0x4f, 
            0x40, 0x45, 0x45, 0x41, 
        };
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        byte x;
        x = (WindowWidth - LogoLength * 4) / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            byte y;
            y = 7;
            repeat (4) {
                Locate(x, y);
                repeat (4) {
                    Put(*p);
                    ++p;
                }
                ++y;
            }
            x += 4;
        }
    }
    PrintS((WindowWidth - 19) / 2, 19, "PUSH TRIGGER BUTTON");
    PrintS(WindowWidth - 12, 23, "INUFUTO 2022");
}


void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}
