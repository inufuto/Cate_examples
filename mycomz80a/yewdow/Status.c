#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

constexpr byte Char_Remain = Char_Car;

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
    PrintS(Vram + VramRowSize * 1 + 64, "SCORE");
    PrintS(Vram + VramRowSize * 6 + 64, "HI-SCORE");
    PrintS(Vram + VramRowSize * 11 + 64, "STAGE");
    PrintByteNumber2(Vram + VramRowSize * 11 + 76, CurrentStage + 1);
    PrintS(Vram + VramRowSize * 14 + 64, "TIME");

    {
        word vram;
        vram = Vram + VramRowSize * 21 + 33 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = Put2C(vram, Char_Remain);
                Erase2(vram);
                vram = Put(vram + VramRowSize, i + 0x10);
            }
            else {
                do {
                    vram = Put2C(vram, Char_Remain);
                    --i;
                } while (i > 0);
            }
        }
    }

    PrintScore();
    PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 3 + 68, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 8 + 68, HiScore);
    PrintC(vram, '0');
}

void PrintTime()
{
    PrintByteNumber3(Vram + VramRowSize * 14 + 74, StageTime);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 11 + 24, "GAME OVER");
}

void PrintTimeUp() 
{
    PrintS(Vram + VramRowSize * 11 + 26, "TIME UP");
}

void Title()
{
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        static const byte[] TitleBytes = {
            0x0f, 0x00, 0x0f, 0x00, 
            0x0d, 0x0a, 0x07, 0x08, 
            0x00, 0x0f, 0x00, 0x0c, 
            0x00, 0x05, 0x00, 0x00, 
            0x00, 0x00, 0x00, 0x00, 
            0x07, 0x0b, 0x0c, 0x03, 
            0x07, 0x05, 0x0c, 0x03, 
            0x05, 0x01, 0x04, 0x05, 
            0x00, 0x00, 0x00, 0x00, 
            0x03, 0x0f, 0x08, 0x07, 
            0x03, 0x0f, 0x0c, 0x03, 
            0x05, 0x01, 0x00, 0x05, 
            0x0f, 0x00, 0x00, 0x00, 
            0x0f, 0x08, 0x07, 0x0b, 
            0x0f, 0x0c, 0x03, 0x0f, 
            0x05, 0x00, 0x05, 0x01, 
            0x00, 0x00, 0x00, 0x00, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x0c, 0x03, 0x03, 0x0f, 
            0x04, 0x05, 0x05, 0x01, 
        };
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 8 + 6 * VramStep;
        p = TitleBytes;
        repeat (5) {
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
    PrintS(Vram + VramRowSize * 18 + 18, "PUSH SLOW KEY");
    PrintS(Vram + VramRowSize * 20 + 18, "OR HTAB KEY");
    PrintS(Vram + VramRowSize * 23 + 40, "INUFUTO 2026");
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
}


void DrawFence()
{
    word top, bottom;
    top = Vram;
    bottom = Vram + VramRowSize * 23;
    repeat(StageWidth) {
        top = Put(top, Char_Fence);
        bottom = Put(bottom, Char_Fence + 1);
    }
}