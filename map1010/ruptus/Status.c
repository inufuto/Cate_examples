#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "Rader.h"

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
    // ClearScreen();

    PrintS(Vram + 24, "SCORE");
    PrintS(Vram + VramRowSize * 3 + 24, "HI-SCORE");
    PrintS(Vram + VramRowSize * 6 + 24, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 6 + 30, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize + 26, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize * 4 + 26, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    byte i;
    pVram= Vram + VramRowSize * 9 + 24;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            VPut2(pVram, Char_Fighter);
            pVram += 2;
            ++i;
        }
    }
    else {
        VPut2(pVram, Char_Fighter);
        pVram += 2;
        VErase2(pVram);
        pVram += 2;
        PrintByteNumber2(Vram + VramRowSize * 10 + 26, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        VErase2(pVram);
        pVram += 2;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramRowSize * 11 + 7;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramRowSize - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 12 + 8, "GAME OVER");
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
    HideAllSprites();
    PrintStatus();

    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 8;
        p = TitleBytes;
        repeat (6) {
            VPut4(pVram, p);
            pVram += 4;
            p += 16;
        }
    }
    PrintS(Vram + VramRowSize * 17 + 5, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 18 + 5, "OR SHIFT KEY");
}
