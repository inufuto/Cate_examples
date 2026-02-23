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
    PrintS(VramLeftTop + VramWidth * 0 + 24, "SCORE");
    PrintS(VramLeftTop + VramWidth * 4 + 24, "HI-SCORE");
    PrintS(VramLeftTop + VramWidth * 8 + 24, "STAGE");
    PrintByteNumber2(VramLeftTop + VramWidth * 8 + 30, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(VramLeftTop + VramWidth * 2 + 26, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(VramLeftTop + VramWidth * 6 + 26, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= VramLeftTop + VramWidth * 9 + 24;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            VPut2(vram, Char_Remain);
            vram += 2;
            ++i;
        }
    }
    else {
        VPut2(vram, Char_Remain);
        vram += 2;
        VErase2(vram);
        vram += 2;
        PrintByteNumber2(VramLeftTop + VramWidth * 10 + 26, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        VErase2(vram);
        vram += 2;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = VramLeftTop + WindowWidth * 11 + 7;
    repeat (height) {
        repeat (width) {
            VPut1(vram, GChar_Space);
            ++vram;
        }
        vram += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(VramLeftTop + VramWidth * 12 + 8, "GAME OVER");
}

static const byte[] TitleBytes = {
    //	R
    0x5c, 0x57, 0x55, 0x5b, 
    0x5c, 0x53, 0x58, 0x5f, 
    0x5c, 0x57, 0x5f, 0x52, 
    0x54, 0x51, 0x54, 0x55, 
    //	U
    0x5c, 0x53, 0x50, 0x5f, 
    0x5c, 0x53, 0x50, 0x5f, 
    0x5c, 0x53, 0x50, 0x5f, 
    0x50, 0x55, 0x55, 0x51, 
    //	P
    0x5c, 0x57, 0x55, 0x5b, 
    0x5c, 0x53, 0x50, 0x5f, 
    0x5c, 0x57, 0x55, 0x51, 
    0x54, 0x51, 0x50, 0x50, 
    //	T
    0x54, 0x5d, 0x57, 0x51, 
    0x50, 0x5c, 0x53, 0x50, 
    0x50, 0x5c, 0x53, 0x50, 
    0x50, 0x54, 0x51, 0x50, 
    //	U
    0x5c, 0x53, 0x50, 0x5f, 
    0x5c, 0x53, 0x50, 0x5f, 
    0x5c, 0x53, 0x50, 0x5f, 
    0x50, 0x55, 0x55, 0x51, 
    //	S
    0x58, 0x57, 0x55, 0x5b, 
    0x54, 0x5b, 0x5a, 0x52, 
    0x58, 0x52, 0x50, 0x5f, 
    0x50, 0x55, 0x55, 0x51, 
};

void Title()
{
    ClearScreen();
    // HideAllSprites();
    PrintStatus();

    {
        ptr<byte> p;
        word vram;
        vram = VramLeftTop + VramWidth * 5;
        p = TitleBytes;
        repeat (6) {
            word vramRow;
            vramRow = vram;
            repeat (4) {
                word vramChar;
                vramChar = vramRow;
                repeat (4) {
                    VPut1(vramChar, *p);
                    ++p;
                    ++vramChar;
                }
                vramRow += VramWidth;
            }
            vram += 4;
        }
    }
    PrintS(VramLeftTop + VramWidth * 17 + 5, "PUSH SPACE KEY");
    PrintS(VramLeftTop + VramWidth * 18 + 5, "OR RETURN KEY");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         VPut1(vram, c);
    //         ++vram;
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramWidth - 16;
    //         }
    //     }
    // }
}
