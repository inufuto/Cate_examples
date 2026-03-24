#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "Rader.h"
#include "Fighter.h"

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
    PrintS(Vram + VramWidth * 3 + 24, "HI-SCORE");
    PrintS(Vram + VramWidth * 6 + 24, "STAGE");
    PrintByteNumber2(Vram + VramWidth * 6 + 30, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramWidth + 26, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramWidth * 4 + 26, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    byte i;
    pVram= Vram + VramWidth * 9 + 24;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            pVram = Put2C(pVram, Char_Remain);
            ++i;
        }
    }
    else {
        pVram = Put2C(pVram, Char_Remain);
        pVram = Erase2(pVram);
        PrintByteNumber2(Vram + VramWidth * 10 + 26, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        pVram = Erase2(pVram);
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    ptr<byte> pVram;

    pVram = Vram + VramWidth * 11 + 7;
    repeat (height) {
        repeat (width) {
            pVram = PrintC(pVram, ' ');
        }
        pVram += VramWidth - width;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramWidth * 12 + 8, "GAME OVER");
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
        ptr<byte> pVram, pAttr;
        pVram = Vram + VramWidth * 8;
        p = TitleBytes;
        repeat (6) {
            pVram = Put4S(pVram, p);
            p += 16;
        }
    }
    PrintS(Vram + VramRowSize * 17 + 7 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 18 + 7 * VramStep, "X:CONTINUE");
    // {
    //     ptr<byte> v = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         v = Put(v, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             v += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}

