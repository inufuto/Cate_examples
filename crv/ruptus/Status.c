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

    PrintS(Vram + 24, "SCORE");
    PrintS(Vram + VramWidth * 3 + 24, "HI-SCORE");
    PrintS(Vram + VramWidth * 6 + 24, "STAGE");
    PrintByteNumber2(Vram + VramWidth * 6 + 30, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    {
        word vram;
        vram= Vram + VramWidth * 12 + 24;
        repeat(12) {
            repeat(8) {
                vram = Put(vram, Char_Map);
            }
            vram += VramWidth - 8;
        }
    }
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramWidth + 26, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramWidth * 4 + 26, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= Vram + VramWidth * 9 + 24;
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
        PrintByteNumber2(Vram + VramWidth * 10 + 26, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        vram = Erase2(vram);
        ++i;
    }
}


// static void EraseVVram() 
// {
//     constexpr byte width = 12;
//     constexpr byte height = 3;    
//     word vram;

//     vram = Vram + VramWidth * 11 + 7;
//     repeat (height) {
//         repeat (width) {
//             vram = PrintC(vram, ' ');
//         }
//         vram += VramWidth - width;
//     }
// }

void PrintGameOver()
{
    // EraseVVram();
    PrintS(Vram + VramWidth * 12 + 8, "GAME OVER");
}

static const byte[] TitleBytes = {
    //	R
    0x2c, 0x27, 0x25, 0x2b, 
    0x2c, 0x23, 0x28, 0x2f, 
    0x2c, 0x27, 0x2f, 0x22, 
    0x24, 0x21, 0x24, 0x25, 
    //	U
    0x2c, 0x23, 0x20, 0x2f, 
    0x2c, 0x23, 0x20, 0x2f, 
    0x2c, 0x23, 0x20, 0x2f, 
    0x20, 0x25, 0x25, 0x21, 
    //	P
    0x2c, 0x27, 0x25, 0x2b, 
    0x2c, 0x23, 0x20, 0x2f, 
    0x2c, 0x27, 0x25, 0x21, 
    0x24, 0x21, 0x20, 0x20, 
    //	T
    0x24, 0x2d, 0x27, 0x21, 
    0x20, 0x2c, 0x23, 0x20, 
    0x20, 0x2c, 0x23, 0x20, 
    0x20, 0x24, 0x21, 0x20, 
    //	U
    0x2c, 0x23, 0x20, 0x2f, 
    0x2c, 0x23, 0x20, 0x2f, 
    0x2c, 0x23, 0x20, 0x2f, 
    0x20, 0x25, 0x25, 0x21, 
    //	S
    0x28, 0x27, 0x25, 0x2b, 
    0x24, 0x2b, 0x2a, 0x22, 
    0x28, 0x22, 0x20, 0x2f, 
    0x20, 0x25, 0x25, 0x21, 
};

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();

    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramWidth * 8;
        p = TitleBytes;
        repeat (6) {
            vram = Put4S(vram, p);
            p += 16;
        }
    }
    PrintS(Vram + VramWidth * 17 + 3, "PUSH TRIGGER BUTTON");
}

void PrintRader(byte x, byte y, byte c)
{
    word w,vram;
    x = (x - 8) >> 4;
    y = (y - 8) >> 4;
    w = y;
    w <<= 5;
    vram = Vram + VramWidth * 12 + 24 + w + x;
    Put(vram, c);
}