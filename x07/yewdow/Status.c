#include "Status.h"
#include "Vram.h"
#include "Main.h"
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
    PrintByteNumber2(Vram + 1 * VramRowSize + (ScoreLeft + 9), CurrentStage + 1);
    PrintS(Vram + 2 * VramRowSize + ScoreLeft, "TIME");
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
    PrintTime();
}

void PrintScore()
{
    word yx;
    
    yx = PrintNumber5(Vram + 0 * VramRowSize + (ScoreLeft + 5), Score);
    PrintC(yx, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + 2 * VramRowSize + (ScoreLeft + 8), StageTime);
}

void PrintGameOver()
{
    VPrintS(VVram + VVramWidth * 6 + 3, "GAME OVER");
    VVramToVram();
}

void PrintTimeUp() 
{
    VPrintS(VVram + VVramWidth * 6 + 5, "TIME UP");
    VVramToVram();
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus(); 

    {
        static const byte[] TitleBytes = {
            0xf0, 0xf0, 0x00, 0x00, 0x00, 0x00, 0xf0, 0x00, 
            0x00, 0x00, 0xd3, 0xe1, 0xeb, 0x5a, 0xaf, 0x1e, 
            0xf1, 0xeb, 0x5a, 0xaf, 0x0f, 0x05, 0xec, 0x5a, 
            0xaf, 0x5a, 0xf5, 0xaf, 0x5a, 0xaf, 0x0c, 0x00, 
            0xc8, 0x4c, 0xc8, 0x0c, 0xc0, 0xc8, 0x4c, 0xc8, 
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
