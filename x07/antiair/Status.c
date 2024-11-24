#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Print.h"
#include "VVram.h"

constexpr byte ScoreLeft = 9;

static word PrintS(word yx, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        yx = PrintC(yx, c);
        ++p;
    }
    return yx;
}

void PrintStatus() 
{
    PrintS(Vram + 0 * VramRowSize + ScoreLeft, "SCORE");   
    PrintS(Vram + 1 * VramRowSize + ScoreLeft, "STAGE");
    {
        word yx;
        yx = Vram + 3 * VramRowSize + ScoreLeft;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                yx = PrintC(yx, Char_Remain);
                yx = PrintC(yx, i + 0x30);
            }
            else {
                do {
                    yx = PrintC(yx, Char_Remain);
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
    word yx;
    
    yx = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 5), Score);
    PrintC(yx, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 9), CurrentStage + 1);
}

void PrintGameOver()
{
    VPrintS(VVram + VVramWidth * 6 + 3, "GAME OVER");
    VVramToVram();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 

    {
        static const byte[] TitleBytes = {
            0x7c, 0xb5, 0xb5, 0xac, 0xfc, 0x5a, 0x1e, 0xd2, 
            0x00, 0x00, 0xf0, 0xf5, 0xef, 0xa0, 0xf0, 0x5a, 
            0x5a, 0x5a, 0xf5, 0xeb, 0xfc, 0xf4, 0x84, 0x80, 
            0xc0, 0x48, 0x5e, 0xda, 0xf5, 0xbe, 0xc0, 0xc0, 
            0x00, 0x00, 0x00, 0x00, 0x48, 0x48, 0xc4, 0x8c, 
        };
        constexpr byte TitleLength = 5;
        constexpr byte TitleLeft = (VVramWidth - TitleLength * 4) / 2;
        ptr<byte> pVVram = VVram + TitleLeft;
        ptr<byte> p = TitleBytes;
        repeat (4) {
            repeat (TitleLength * 2) {
                byte b = *p; ++p;
                *pVVram = b & 0xf0; ++pVVram;
                *pVVram = b << 4; ++pVVram;
            }
            pVVram += VramWidth - TitleLength * 4;
        }
        VPrintS(VVram + VVramWidth * 4 + (TitleLeft + TitleLength * 4 - 8), "MINI");
    }
    VPrintS(VVram + VVramWidth * 10, "PUSH SPACE");
    VPrintS(VVram + VVramWidth * 13 + 12, "OR INS");
    VVramToVram();
}


void AddScore(word pts)
{
    Score += pts;
    PrintScore();
}


void DrawFence()
{
    word yx = Vram + 8;
    repeat (4) {
        PrintC(yx, Char_Fence);
        yx += VramRowSize;
    }
}