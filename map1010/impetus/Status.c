#include "Status.h"
#include "Vram.h"
#include "Main.h"
#include "Sprite.h"
#include "VVram.h"
#include "Chars.h"
#include "Print.h"
#include "CopyMemory.h"

constexpr byte StatusHeight = 2;

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
    c = Char_Fighter;
    repeat (2) {
        repeat (2) {
            pVram = Put(pVram, c);
            ++c;
        }
        pVram += VramRowSize - 2;
    }
}

void PrintStatus() 
{
    PrintS(Vram + 1, "SCORE");
    PrintS(Vram + 8, "HI-SCORE");
    PrintS(Vram + 18, "STAGE");
    {
        ptr<byte> pVram;
        pVram = Vram + 27;
        if (RemainCount > 1) {
            byte i;
            i = RemainCount - 1;
            if (i > 2) {
                PrintRemain(pVram);
                Put(Vram + 29, Char_Space);
                Put(Vram + 30, Char_Space);
                PrintC(Vram + VramRowSize + 29, i + '0');
                Put(Vram + VramRowSize + 30, Char_Space);
            }
            else {
                do {
                    PrintRemain(pVram);
                    pVram += 2;
                    --i;
                } while (i > 0);
            }
        }
    }

    PrintScore();
    PrintStage();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Vram + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Vram + VramRowSize + 9, HiScore);
    PrintC(pVram, '0');
}

void PrintStage()
{
    PrintByteNumber3(Vram + VramRowSize + 20, CurrentStage + 1);
}

void PrintGameOver()
{
    PrintS(Vram + VramRowSize * 12 + 11, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	I
        0x04, 0x0d, 0x07, 0x01, 
        0x00, 0x0c, 0x03, 0x00, 
        0x00, 0x0c, 0x03, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
        //	M
        0x0c, 0x07, 0x07, 0x0b, 
        0x0c, 0x03, 0x03, 0x0f, 
        0x0c, 0x03, 0x03, 0x0f, 
        0x04, 0x01, 0x01, 0x05, 
        //	P
        0x0c, 0x07, 0x05, 0x0b, 
        0x0c, 0x03, 0x00, 0x0f, 
        0x0c, 0x07, 0x05, 0x01, 
        0x04, 0x01, 0x00, 0x00, 
        //	E
        0x0c, 0x07, 0x05, 0x01, 
        0x0c, 0x0b, 0x0a, 0x02, 
        0x0c, 0x03, 0x00, 0x00, 
        0x04, 0x05, 0x05, 0x01, 
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

    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = Vram + VramRowSize * 7 + (32 - 4 * 7) / 2;
        p = TitleBytes;
        repeat (7) {
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
}
