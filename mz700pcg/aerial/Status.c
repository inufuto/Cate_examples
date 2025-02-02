#include "Status.h"
#include "Vram.h"
#include "Stage.h"
#include "Main.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"


static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}


static void PrintRemain(ptr<byte> pVram)
{
    byte c;
    c = Char_MyFighter;
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramWidth - 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + VramWidth * 0 + 32, "SCORE");
    PrintS(Vram + VramWidth * 4 + 32, "HI-SCORE");
    PrintS(Vram + VramWidth * 8 + 32, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + VramWidth * 20 + 32;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(pVram);
                pVram += 3;
                Put(pVram, Char_Space);
                PrintC(pVram + VramWidth, i + '0');
                ++pVram;
            }
            else {
                do {
                    PrintRemain(pVram);
                    pVram += 3;
                    --i;
                } while (i > 0);
            }
        }
        repeat (2) {
            repeat (2) {
                pVram = Put(pVram, Char_Space);
            }
            pVram += VramWidth - 2;
        }                
    }
    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramWidth * 2 + 34, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramWidth * 5 + 34, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(Vram + VramWidth * 8 + 37, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramWidth * 11 + 12, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	A
        0x80, 0x8e, 0x8d, 0x82, 
        0x8c, 0x83, 0x80, 0x8f, 
        0x8c, 0x87, 0x85, 0x8f, 
        0x84, 0x81, 0x80, 0x85, 
        //	E
        0x8c, 0x87, 0x85, 0x81, 
        0x8c, 0x8b, 0x8a, 0x82, 
        0x8c, 0x83, 0x80, 0x80, 
        0x84, 0x85, 0x85, 0x81, 
        //	R
        0x8c, 0x87, 0x85, 0x8b, 
        0x8c, 0x83, 0x88, 0x8f, 
        0x8c, 0x87, 0x8f, 0x82, 
        0x84, 0x81, 0x84, 0x85, 
        //	I
        0x84, 0x8d, 0x87, 0x81, 
        0x80, 0x8c, 0x83, 0x80, 
        0x80, 0x8c, 0x83, 0x80, 
        0x84, 0x85, 0x85, 0x81, 
        //	A
        0x80, 0x8e, 0x8d, 0x82, 
        0x8c, 0x83, 0x80, 0x8f, 
        0x8c, 0x87, 0x85, 0x8f, 
        0x84, 0x81, 0x80, 0x85, 
        //	L
        0x8c, 0x83, 0x80, 0x80, 
        0x8c, 0x83, 0x80, 0x80, 
        0x8c, 0x83, 0x80, 0x80, 
        0x84, 0x85, 0x85, 0x81, 
    };
    ClearScreen(); 
    HideAllSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + 4;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4;
            }
            pVram += 4 - VramRowSize * 4;
        }
    }
    PrintS(Vram + VramRowSize * 19 + 9, "PUSH SPACE KEY");
    PrintS(Vram + VramRowSize * 20 + 9, "OR SHIFT KEY");
    PrintS(Vram + VramRowSize * 23 + 27 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte>pVram = Vram;
    //     byte c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 15) == 0) {
    //             pVram += VramRowSize - 16;
    //         }
    //     }
    // }
}
