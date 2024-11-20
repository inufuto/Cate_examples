#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Man.h"

extern void _deb();

constexpr byte ScoreLeft = 15;

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
    PrintS(Vram02, "SCORE");   
    PrintS(Vram12, "STAGE");
    PrintByteNumber2(Vram13 + 10, CurrentStage + 1);
    PrintS(Vram22, "TIME");
    {
        ptr<byte> pVram = Vram32;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, ManChars);
                pVram = PrintC(pVram, ' ');
                pVram = PrintC(pVram, i + 0x30);
            }
            else {
                do {
                    pVram = Put2S(pVram, ManChars);
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
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram02 + 24, Score);
    PrintC(pVram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram23 + 6, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram20 + 6, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram20 + 10, "TIME UP");
}

void PrintPerfect() 
{
    PrintS(Vram20 + 10, "PERFECT");
}

void Title()
{
    static const byte[] TitleBytes = {
        0x00, 0x7f, 0x7f, 0x08, 0x08, 0x08, 0x7f, 0x7f, //	H
        0x00, 0x3e, 0x7f, 0x41, 0x41, 0x41, 0x7f, 0x3e, //	O
        0x00, 0x7f, 0x7f, 0x11, 0x11, 0x11, 0x1f, 0x0e, //	P
        0x00, 0x7f, 0x7f, 0x01, 0x7f, 0x01, 0x7f, 0x7e, //	M
        0x00, 0x7c, 0x7e, 0x13, 0x11, 0x13, 0x7e, 0x7c, //	A
        0x00, 0x7f, 0x7f, 0x0e, 0x1c, 0x38, 0x7f, 0x7f, //	N
    };
    constexpr byte TitleLength = 6;
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> pVram = Vram00 + 0;
        ptr<byte> p = TitleBytes;
        repeat (TitleLength * 4 * 2) {
            pVram = PutByte(pVram, *p);
            ++p;
        }
        PrintS(Vram11 + 2, "MINI");
    }
    PrintS(Vram20, "PUSH 'Z' KEY");
    PrintS(Vram30 + 8, "OR 'X' KEY");
}