#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"

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


static word PrintRemain(word vram)
{
    byte c;
    c = Char_Remain;
    repeat (2) {
        repeat (2) {
            vram = Put(vram, c);
            ++c;
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + (2 * VramStep - VramRowSize * 2);
}


static word EraseRemain(word vram)
{
    repeat (2) {
        repeat (2) {
            vram = Put(vram, Char_Space);
        }
        vram += VramRowSize - 2 * VramStep;
    }
    return vram + (2 * VramStep - VramRowSize * 2);
}


void PrintStatus() 
{
    PrintS(Vram + 1 * VramStep, "SCORE");
    PrintS(Vram + 8 * VramStep, "HI-SCORE");
    PrintS(Vram + 18 * VramStep, "STAGE");
    {
        word vram;
        vram = Vram + 27 * VramStep;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                vram = PrintRemain(vram);
                vram = Put(vram, Char_Space);
                vram = Put(vram, Char_Space);
                vram += VramRowSize - 2 * VramStep;
                vram = PrintC(vram, i + '0');
                vram = Put(vram, Char_Space);
            }
            else {
                do {
                    vram = PrintRemain(vram);
                    --i;
                } while (i != 0);
                EraseRemain(vram);
            }
        }
        else {
            EraseRemain(vram);           
        }
    }
    PrintStage();
    PrintScore();
    // PrintTime();
}

void PrintScore()
{
    word vram;
    
    vram = PrintNumber5(Vram + AsciiRowHeight, Score);
    PrintC(vram, '0');

    vram = PrintNumber5(Vram + AsciiRowHeight + 9 * VramStep, HiScore);
    PrintC(vram, '0');
}

void PrintStage()
{
    PrintByteNumber2(Vram + AsciiRowHeight + 20 * VramStep, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
    DrawAll();
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
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        word vram;
        vram = Vram + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        p = TitleBytes;
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
    PrintS(Vram + AsciiRowHeight * 12 + 11 * VramStep, "S:START");
    PrintS(Vram + AsciiRowHeight * 13 + 11 * VramStep, "C:CONTINUE");
    PrintS(Vram + AsciiRowHeight * 15 + 20 * VramStep, "INUFUTO 2025");
    // {
    //     word vram = Vram + VramRowSize * 3;
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
