#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "Rader.h"

void PrintS(byte x, byte y, ptr<byte> p)
{
    byte c;
    VLocate(x, y);
    while ((c = *p) != 0) {
        PrintC(c);
        ++p;
    }
}

void PrintStatus() 
{
    // ClearScreen();

    PrintS(24, 0, "SCORE"); 
    PrintS(24, 3, "HI-SCORE");
    PrintS(24, 6, "STAGE");
    VLocate(30, 6); PrintByteNumber2(CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    VLocate(26, 1);
    PrintNumber5(Score);
    PrintC('0');

    VLocate(26, 4);
    PrintNumber5(HiScore);
    PrintC('0');
}

void PrintRemain()
{
    byte x, i;
    constexpr byte y = 9;
    x = 24;
    // pVram= VramLeftTop + VramWidth * 9 + 24;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            VPut2(x, y, Char_Fighter);
            x += 2;
            ++i;
        }
    }
    else {
        VPut2(x, y, Char_Fighter);
        x += 2;
        VErase2(x, y);
        x += 2;
        VLocate(26, 10); PrintByteNumber2(RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        VErase2(x, y);
        x += 2;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    constexpr byte x = 7;
    byte y;

    y = 11;
    repeat (height) {
        VLocate(x, y);
        repeat (width) {
            PrintC(' ');
        }
        ++y;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(8, 12, "GAME OVER");
}

static const byte[] TitleBytes = {
    //	R
    0x4c, 0x47, 0x45, 0x4b, 
    0x4c, 0x43, 0x48, 0x4f, 
    0x4c, 0x47, 0x4f, 0x42, 
    0x44, 0x41, 0x44, 0x45, 
    //	U
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x40, 0x45, 0x45, 0x41, 
    //	P
    0x4c, 0x47, 0x45, 0x4b, 
    0x4c, 0x43, 0x40, 0x4f, 
    0x4c, 0x47, 0x45, 0x41, 
    0x44, 0x41, 0x40, 0x40, 
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

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();

    {
        ptr<byte> p;
        byte x;
        constexpr byte y = 8;
        x = 0;
        p = TitleBytes;
        repeat (6) {
            VPut4(x, y, p);
            x += 4;
            p += 16;
        }
    }
    PrintS(3, 17, "PUSH TRIGGER BUTTON");
}
