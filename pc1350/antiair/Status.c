#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Print.h"
#include "Cannon.h"

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
    {
        ptr<byte> pVram = Vram32;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                pVram = Put2S(pVram, CannonChars);
                pVram = PrintC(pVram, ' ');
                pVram = PrintC(pVram, i + 0x30);
            }
            else {
                do {
                    pVram = Put2S(pVram, CannonChars);
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
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram02 + 24, Score);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram13 + 10, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram20 + 6, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        0x7e, 0x7f, 0x11, 0x11, 0x7f, 0x7e, 0x00, 0x1f, 
        0x1f, 0x06, 0x0c, 0x1f, 0x1f, 0x00, 0x01, 0x01, 
        0x1f, 0x1f, 0x01, 0x01, 0x00, 0x1f, 0x1f, 0x00, 
        0x00, 0x7e, 0x7f, 0x11, 0x11, 0x7f, 0x7e, 0x00, 
        0x7c, 0x7c, 0x00, 0x7c, 0x7c, 0x24, 0x7c, 0x58, 
    };
    constexpr byte TitleLength = 5;
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 
    {
        ptr<byte> pVram = Vram00 + 4;
        ptr<byte> p = TitleBytes;
        repeat (TitleLength * 4 * 2) {
            pVram = PutByte(pVram, *p);
            ++p;
        }
        PrintS(Vram11, "MINI");
    }
    PrintS(Vram20, "PUSH 'Z' KEY");
    PrintS(Vram30 + 8, "OR 'X' KEY");
}


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}


void DrawFence()
{
    Vram01[18] = 0xaa;
    Vram11[18] = 0xaa;
    Vram21[18] = 0xaa;
    Vram31[18] = 0xaa;
}