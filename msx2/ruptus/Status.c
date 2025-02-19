#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"

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

    PrintS(Vram + 24 * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 3 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 6 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 6 + 30 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    {
        word vram;
        vram= Vram + VramRowSize * 12 + 24 * VramStep;
        repeat(12) {
            repeat(8) {
                vram = Put(vram, Char_Map);
            }
            vram += VramRowSize - 8 * VramStep;
        }
    }
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize + 26 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 4 + 26 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= Vram + VramRowSize * 9 + 24 * VramStep;
    if (RemainFighterCount < 5) {
        i = 1;
        while (i < RemainFighterCount) {
            vram = Put2C(vram, Char_Remain);
            ++i;
        }
    }
    else {
        vram = Put2C(vram, Char_Remain);
        vram = Erase2(vram);
        PrintByteNumber2(Vram + VramRowSize * 10 + 26 * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        vram = Erase2(vram);
        ++i;
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "GAME OVER");
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
        vram = Vram + VramRowSize * 8;
        p = TitleBytes;
        repeat (6) {
            vram = Put4S(vram, p);
            p += 16;
        }
    }
    PrintS(Vram + VramRowSize * 17 + 5 * VramStep, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 18 + 5 * VramStep, "OR GRPH KEY");
    // {
    //     word vram;
    //     byte c;
    //     vram = Vram;
    //     c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}

// void PrintRader(byte x, byte y, byte c)
// {
//     word w,vram;
//     x = (x - 8) >> 4;
//     y = (y - 8) >> 4;
//     w = y;
//     w <<= 5;
//     vram = Vram + VramRowSize * 12 + 24 + w + x;
//     PrintC(vram, c);
// }