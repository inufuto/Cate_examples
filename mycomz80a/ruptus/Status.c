#include "Status.h"
#include "Vram.h"
#include "VVram.h"
#include "Print.h"
#include "Chars.h"
#include "Sprite.h"
#include "VVram.h"
#include "Main.h"
#include "Stage.h"
#include "Rader.h"

constexpr byte Char_Remain = Char_Fighter;

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
    PrintS(Vram + VramRowSize * 0 + VVramWidth * VramStep, "SCORE");
    PrintS(Vram + VramRowSize * 4 + VVramWidth * VramStep, "HI-SCORE");
    PrintS(Vram + VramRowSize * 8 + VVramWidth * VramStep, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 8 + (VVramWidth + 6) * VramStep, CurrentStage + 1);
    PrintRemain();
    PrintScore();
    PrintRader();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + (VVramWidth + 2) * VramStep, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 6 + (VVramWidth + 2) * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram;
    vram = Vram + VramRowSize * 10 + (VVramWidth + 1) * VramStep;
    if (RemainFighterCount > 1) {
        byte i;
        i = RemainFighterCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Remain);
            Erase2(vram);
            vram = PrintC(vram, i + 0x30);
            vram += 1 - VramRowSize;
        }
        else {
            do {
                vram = Put2C(vram, Char_Remain);
                --i;
            } while (i > 0);
        }
    }
    if (RemainFighterCount < 3) {
        vram = Erase2(vram);
    }
}


void PrintGameOver()
{
    constexpr byte Left = (VVramWidth - 8) / 2;
    PrintS(Vram + VramRowSize * (VramHeight / 2) + Left * VramStep, "GAME OVER");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
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
        constexpr byte LogoLength = 6;
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (VVramWidth - LogoLength * 4)  * VramStep / 2;
        p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4 * VramStep;
            }
            vram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + (VVramWidth - 14) * VramStep / 2, "PUSH SLOW KEY");
    PrintS(Vram + VramRowSize * 21 + (VVramWidth - 14) * VramStep / 2, "OR HTAB KEY");
    // {
    //     byte c;
    //     word vram;
    //     vram = Vram;
    //     c = 0;
    //     repeat (0) {
    //         vram = Put(vram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             vram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}
