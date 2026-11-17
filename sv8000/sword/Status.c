#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Movable.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Sprite;

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
    PrintS(Vram + 0, "SC");
    PrintS(Vram + 9, "HI");
    PrintS(Vram + 18, "ST");
    PrintByteNumber2(Vram + 20, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + 2, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + 11, HiScore);
    PrintC(vram, '0');
}

void PrintRemain()
{
    word vram = Vram + 28;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            vram = Put2C(vram, Char_Sprite);
            Erase2(vram);
            PrintC(vram, i + '0');
        }
        else {
            do {
                vram = Put2C(vram, Char_Sprite);
                --i;
            } while (i != 0);
        }
    }
    if (RemainCount < 3) {
        Erase2(vram);
    }
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}


void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x00, 0x0e, 0x05, 0x0b, 
            0x00, 0x0d, 0x0a, 0x02, 
            0x00, 0x0a, 0x00, 0x0f, 
            0x00, 0x04, 0x05, 0x01, 
            0x0c, 0x03, 0x02, 0x0f, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x04, 0x05, 0x05, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x08, 0x07, 0x0b, 0x0c, 
            0x0c, 0x03, 0x0f, 0x0c, 
            0x00, 0x05, 0x01, 0x04, 
            0x00, 0x00, 0x00, 0x00, 
            0x07, 0x0b, 0x0c, 0x07, 
            0x0b, 0x07, 0x0c, 0x03, 
            0x01, 0x05, 0x04, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x0b, 0x00, 0x0f, 0x08, 
            0x0f, 0x00, 0x0f, 0x0c, 
            0x01, 0x00, 0x0f, 0x0c, 
            0x00, 0x00, 0x05, 0x05, 
            0x0c, 0x03, 0x00, 0x00, 
            0x0c, 0x03, 0x0e, 0x0d, 
            0x0c, 0x03, 0x0f, 0x0c, 
            0x05, 0x00, 0x04, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x02, 0x0f, 0x0d, 0x02, 
            0x03, 0x0f, 0x0e, 0x01, 
            0x00, 0x05, 0x04, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0f, 0x08, 0x07, 0x00, 
            0x0f, 0x0d, 0x02, 0x00, 
            0x05, 0x00, 0x05, 0x00, 
        };
        constexpr byte LogoLength = 8;
        word vram = Vram + VramRowSize * 6 + (32 - LogoLength * 4) / 2;
        ptr<byte> p = TitleBytes;
        repeat (LogoLength) {
            repeat (4) {
                repeat (4) {
                    vram = Put(vram, *p);
                    ++p;
                }
                vram += VramRowSize - 4;
            }
            vram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 17 + 12, "0:START");
    PrintS(Vram + VramRowSize * 19 + 12, "1:CONTINUE");
    PrintS(Vram + VramRowSize * 22 + (32 - 12), "INUFUTO 2026");
    // {
    //     word vram = Vram;
    //     byte c = 0x0;
    //     repeat (20) {
    //         Put(pVram, c);
    //         ++pVram;
    //         ++c;
    //     }
    // }
}
