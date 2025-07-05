#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
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
    // ClearScreen();

    PrintS(Vram + 32 * VramStep, "SCORE");
    PrintS(Vram +VramRowSize * 3 + 32 * VramStep, "HI-SCORE");
    PrintS(Vram +VramRowSize * 6 + 32 * VramStep, "STAGE");
    PrintByteNumber2(Vram +VramRowSize * 6 + 38 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    PrintRader();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram +VramRowSize + 34 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram +VramRowSize * 4 + 34 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= Vram +VramRowSize * 9 + 32 * VramStep;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            Put2C(vram, Char_Remain);
            vram += 2 * VramStep;
            ++i;
        }
    }
    else {
        Put2C(vram, Char_Remain);
        vram += 2 * VramStep;
        Erase2(vram);
        vram += 2 * VramStep;
        PrintByteNumber2(Vram +VramRowSize * 10 + 34 * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        Erase2(vram);
        vram += 2 * VramStep;
        ++i;
    }
}


static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3;    
    word vram;

    vram = Vram +VramRowSize * 11 + 7 * VramStep;
    repeat (height) {
        repeat (width) {
            vram = PrintC(vram, ' ');
        }
        vram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram +VramRowSize * 12 + 8 * VramStep, "GAME OVER");
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
        word vram;
        vram = Vram + VramRowSize * 8 + 4 * VramStep;
        p = TitleBytes;
        repeat (6) {
            Put4C(vram, p);
            vram += 4 * VramStep;
            p += 16;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 11 * VramStep, "Z:START");
    PrintS(Vram + VramRowSize * 20 + 11 * VramStep, "X:CONTINUE");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = Char_Star;
    //     while (c < 150) {
    //         repeat (4) {
    //             Put(vram, c);
    //             ++c;
    //             vram += VramStep;
    //         }
    //         vram += VramRowSize - 4 * VramStep;
    //     }
    // }
}
