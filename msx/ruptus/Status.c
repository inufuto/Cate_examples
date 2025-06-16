#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"

static word PrintS(word address, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        address = PrintC(address, c);
        ++p;
    }
    return address;
}

void PrintStatus() 
{
    // ClearScreen();

    PrintS(Vram + 24, "SCORE");
    PrintS(Vram + VramWidth * 3 + 24, "HI-SCORE");
    PrintS(Vram + VramWidth * 6 + 24, "STAGE");
    PrintByteNumber2(Vram + VramWidth * 6 + 30, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    {
        word address;
        address= Vram + VramWidth * 12 + 24;
        repeat(12) {
            repeat(8) {
                address = PrintC(address, Char_Map);
            }
            address += VramWidth - 8;
        }
    }
}

void PrintScore()
{
    word address;
    
    address = PrintNumber5(Vram + VramWidth + 26, Score);
    PrintC(address, '0');

    address = PrintNumber5(Vram + VramWidth * 4 + 26, HiScore);
    PrintC(address, '0');
}

void PrintRemain()
{
    word address;
    byte i;
    address= Vram + VramWidth * 9 + 24;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            VPut2(address, Char_Fighter);
            address += 2;
            ++i;
        }
    }
    else {
        VPut2(address, Char_Fighter);
        address += 2;
        VErase2(address);
        address += 2;
        PrintByteNumber2(Vram + VramWidth * 10 + 26, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        VErase2(address);
        address += 2;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word address;

    address = Vram + VramWidth * 11 + 7;
    repeat (height) {
        repeat (width) {
            address = PrintC(address, ' ');
        }
        address += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 8, "GAME OVER");
}

static const byte[] TitleBytes = {
    //	R
    0x1c, 0x17, 0x15, 0x1b, 
    0x1c, 0x13, 0x18, 0x1f, 
    0x1c, 0x17, 0x1f, 0x12, 
    0x14, 0x11, 0x14, 0x15, 
    //	U
    0x1c, 0x13, 0x10, 0x1f, 
    0x1c, 0x13, 0x10, 0x1f, 
    0x1c, 0x13, 0x10, 0x1f, 
    0x10, 0x15, 0x15, 0x11, 
    //	P
    0x1c, 0x17, 0x15, 0x1b, 
    0x1c, 0x13, 0x10, 0x1f, 
    0x1c, 0x17, 0x15, 0x11, 
    0x14, 0x11, 0x10, 0x10, 
    //	T
    0x14, 0x1d, 0x17, 0x11, 
    0x10, 0x1c, 0x13, 0x10, 
    0x10, 0x1c, 0x13, 0x10, 
    0x10, 0x14, 0x11, 0x10, 
    //	U
    0x1c, 0x13, 0x10, 0x1f, 
    0x1c, 0x13, 0x10, 0x1f, 
    0x1c, 0x13, 0x10, 0x1f, 
    0x10, 0x15, 0x15, 0x11, 
    //	S
    0x18, 0x17, 0x15, 0x1b, 
    0x14, 0x1b, 0x1a, 0x12, 
    0x18, 0x12, 0x10, 0x1f, 
    0x10, 0x15, 0x15, 0x11, 
};

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();

    {
        ptr<byte> p;
        word address;
        address = Vram + VramWidth * 8;
        p = TitleBytes;
        repeat (6) {
            VPut4(address, p);
            address += 4;
            p += 16;
        }
    }
    PrintS(Vram + VramWidth * 17 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramWidth * 18 + 5, "OR GRPH KEY");
}

void PrintRader(byte x, byte y, byte c)
{
    word w,address;
    x = (x - 8) >> 4;
    y = (y - 8) >> 4;
    w = y;
    w <<= 5;
    address = Vram + VramWidth * 12 + 24 + w + x;
    PrintC(address, c);
}