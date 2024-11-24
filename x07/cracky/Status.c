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
            0x07, 0xcb, 0x5a, 0x00, 0x4b, 0x03, 0x04, 0xc8, //	C
            0x5e, 0xcb, 0x5a, 0x1f, 0x5e, 0xf2, 0x48, 0x4c, //	R
            0x07, 0xd2, 0x5a, 0x0f, 0x5e, 0xcf, 0x48, 0x0c, //	A
            0x07, 0xcb, 0x5a, 0x00, 0x4b, 0x03, 0x04, 0xc8, //	C
            0x5a, 0x1e, 0x5b, 0xe0, 0x5a, 0xd2, 0x48, 0x0c, //	K
            0x5a, 0x5a, 0x4b, 0x78, 0x05, 0xa0, 0x04, 0x80, //	Y
        };
        constexpr byte TitleLength = 6;
        constexpr byte TitleLeft = (VVramWidth - TitleLength * 4) / 2;
        ptr<byte> pVVram = VVram + TitleLeft;
        ptr<byte> p = TitleBytes;
        repeat (TitleLength) {
            repeat (4) {
                repeat (2) {
                    byte b = *p; ++p;
                    *pVVram = b & 0xf0; ++pVVram;
                    *pVVram = b << 4; ++pVVram;
                }
                pVVram += VramWidth - 4;
            }
            pVVram += 4 - VramWidth * 4;
        }
        VPrintS(VVram + VVramWidth * 4 + (TitleLeft + TitleLength * 4 - 8), "MINI");
    }
    // PrintS(Vram + VramRowSize * 0, "CRACKY");
    // VPrintS(VVram + VVramWidth * 4 + 16, "MINI");
    VPrintS(VVram + VVramWidth * 10, "PUSH SPACE");
    VPrintS(VVram + VVramWidth * 13 + 12, "OR INS");
    VVramToVram();
}