#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Window.h"
#include "Rader.h"

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}

void PrintStatus() 
{
    PrintS(VramLeftTop + VramRowSize * 0 + 24 * 2, "SCORE");
    PrintS(VramLeftTop + VramRowSize * 4 + 24 * 2, "HI-SCORE");
    PrintS(VramLeftTop + VramRowSize * 8 + 24 * 2, "STAGE");
    PrintByteNumber2(VramLeftTop + VramRowSize * 8 + 30 * 2, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(VramLeftTop + VramRowSize * 2 + 26 * 2, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(VramLeftTop + VramRowSize * 6 + 26 * 2, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= VramLeftTop + VramRowSize * 9 + 24 * 2;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            VPut2(vram, Char_Fighter);
            vram += 4;
            ++i;
        }
    }
    else {
        VPut2(vram, Char_Fighter);
        vram += 4;
        VErase2(vram);
        vram += 4;
        PrintByteNumber2(VramLeftTop + VramRowSize * 10 + 26 * 2, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        VErase2(vram);
        vram += 4;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = VramLeftTop + VramRowSize * 11 + 7;
    repeat (height) {
        repeat (width) {
            VPut1(vram, Char_Space);
            vram += 2;
        }
        vram += VramRowSize - width * 2;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(VramLeftTop + VramRowSize * 12 + 8 * 2, "GAME OVER");
}

static const byte[] TitleBytes = {
    //	R
    0x0c, 0x07, 0x05, 0x0b, 
    0x0c, 0x03, 0x08, 0x0f, 
    0x0c, 0x07, 0x0f, 0x02, 
    0x04, 0x01, 0x04, 0x05, 
    //	U
    0x0c, 0x03, 0x00, 0x0f, 
    0x0c, 0x03, 0x00, 0x0f, 
    0x0c, 0x03, 0x00, 0x0f, 
    0x00, 0x05, 0x05, 0x01, 
    //	P
    0x0c, 0x07, 0x05, 0x0b, 
    0x0c, 0x03, 0x00, 0x0f, 
    0x0c, 0x07, 0x05, 0x01, 
    0x04, 0x01, 0x00, 0x00, 
    //	T
    0x04, 0x0d, 0x07, 0x01, 
    0x00, 0x0c, 0x03, 0x00, 
    0x00, 0x0c, 0x03, 0x00, 
    0x00, 0x04, 0x01, 0x00, 
    //	U
    0x0c, 0x03, 0x00, 0x0f, 
    0x0c, 0x03, 0x00, 0x0f, 
    0x0c, 0x03, 0x00, 0x0f, 
    0x00, 0x05, 0x05, 0x01, 
    //	S
    0x08, 0x07, 0x05, 0x0b, 
    0x04, 0x0b, 0x0a, 0x02, 
    0x08, 0x02, 0x00, 0x0f, 
    0x00, 0x05, 0x05, 0x01, 
};

void Title()
{
    ClearScreen();
    // HideAllSprites();
    PrintStatus();

    {
        ptr<byte> p;
        word vram;
        vram = VramLeftTop + VramRowSize * 5;
        p = TitleBytes;
        repeat (6) {
            word rowAddress;
            rowAddress = vram;
            repeat (4) {
                word charAddress;
                charAddress = rowAddress;
                repeat (4) {
                    VPut1(charAddress, *p);
                    ++p;
                    charAddress += 2;
                }
                rowAddress += VramRowSize;
            }
            vram += 4 * 2;
        }
    }
    PrintS(VramLeftTop + VramRowSize * 17 + 5 * 2, "PUSH SPACE KEY");
    PrintS(VramLeftTop + VramRowSize * 18 + 5 * 2, "OR SHIFT KEY");
}

