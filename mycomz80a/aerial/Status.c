#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"
#include "VVram.h"

static word PrintS(word vram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        vram = PrintC(vram, c);
        ++p;
    }
    return vram;
}


static void PrintRemain(word vram)
{
    byte c;
    c = Char_Fighter;
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramWidth - 2 * VramStep;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramRowSize * 0 + 64, "SCORE");
    PrintS(Vram + VramRowSize * 5 + 64, "HI-SCORE");
    PrintS(Vram + VramRowSize * 10 + 64, "STAGE");
    {
        word vram;
        vram = Vram + VramRowSize * 20 + 64;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(vram);
                vram += 3 * 2;
                vram = PrintC(vram, i + '0');
            }
            else {
                do {
                    PrintRemain(vram);
                    vram += 3 * 2;
                    --i;
                } while (i > 0);
            }
        }
        repeat (2) {
            repeat (2) {
                Put(vram, Char_Space);
                vram += 2;
            }
            vram += VramWidth - 2 * 2;
        }                
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + VramRowSize * 2 + 68, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + VramRowSize * 7 + 68, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber3(Vram + VramRowSize * 10 + 74, CurrentStage + 1);
}

static void EraseWindow() 
{
    constexpr byte width = 12;
    constexpr byte height = 3 + 1;    

    word vram = Vram + VramRowSize * 9 + 10 * VramStep;
    repeat (height) {
        repeat (width) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - width * VramStep;
    }
}

void PrintGameOver()
{
    EraseWindow();
    PrintS(Vram + VramRowSize * 10 + 24, "GAME OVER");
}


void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x00, 0x0e, 0x0d, 0x02, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x0f, 
        0x04, 0x01, 0x00, 0x05, 
        //	E
        0x0c, 0x07, 0x05, 0x01, 
        0x0c, 0x0b, 0x0a, 0x02, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
        //	R
        0x0c, 0x07, 0x05, 0x0b, 
        0x0c, 0x03, 0x08, 0x0f, 
        0x0c, 0x07, 0x0f, 0x02, 
        0x04, 0x01, 0x04, 0x05, 
        //	I
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
        //	A
        0x00, 0x0e, 0x0d, 0x02, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x0f, 
        0x04, 0x01, 0x00, 0x05, 
        //	L
        0x0c, 0x03, 0x00, 0x00, 
        0x0c, 0x03, 0x00, 0x00, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
    };
    ClearScreen(); 
    ClearVVram();
    HideAllSprites();
    PrintStatus();
    {
        word vram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        ptr<byte> p = TitleBytes;
        repeat (6) {
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
    PrintS(Vram + VramRowSize * 23 + 27 * 2, "INUFUTO 2026");
}
