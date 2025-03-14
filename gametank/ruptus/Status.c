#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Chars.h"
#include "Print.h"
#include "Sprite.h"
#include "Rader.h"

constexpr word AsciiRowHeight = VramWidth * AsciiHeight;

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
    PrintS(Vram + AsciiRowHeight * 3 + 24 * VramStep, "HI-SCORE");
    PrintS(Vram + AsciiRowHeight * 6 + 24 * VramStep, "STAGE");
    PrintByteNumber2(Vram + AsciiRowHeight * 6 + 30 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
    {
        word vram;
        vram= Vram + VramRowSize * RaderTop + 24 * VramStep;
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
    
    vram = PrintNumber5(Vram + AsciiRowHeight + 26 * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + AsciiRowHeight * 4 + 26 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    byte i;
    vram= Vram + VramRowSize * 12 + 24 * VramStep;
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
        PrintByteNumber2(Vram + VramRowSize * 12 + 26 * VramStep, RemainFighterCount - 1);
        i = 3;
    }
    while (i < 4) {
        Erase2(vram);
        vram += 2 * VramStep;
        ++i;
    }
}


void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 8 * VramStep, "GAME OVER");
    DrawAll();
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
        word vram;
        vram = Vram + VramRowSize * 7;
        p = TitleBytes;
        repeat (6) {
            Put4S(vram, p);
            vram += 4 * VramStep;
            p += 16;
        }
    }
    PrintS(Vram + AsciiRowHeight * 13 + (VVramWidth - 7) * VramStep / 2, "S:START");
    PrintS(Vram + AsciiRowHeight * 14 + (VVramWidth - 7) * VramStep / 2, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 16 + (VVramWidth - 12) * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram;
    //     byte c = 0;
    //     repeat (Char_End) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - CharWidth * 16;
    //         }
    //     }
    // }
    PresentBackground();
    SwitchPage();
}
