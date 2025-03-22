#include "Status.h"
#include "Vram.h"
#include "Sprite.h"
#include "Print.h"
#include "Chars.h"


constexpr ptr<byte> Status = VramFront + VramStep;

static ptr<byte> PrintS(ptr<byte> pVram, ptr<byte> p)
{
    byte c;
    while ((c = *p) != 0) {
        pVram = PrintC(pVram, c);
        ++p;
    }
    return pVram;
}


void PrintStatus() 
{
    PrintS(Status + 1 * VramStep, "SCORE");
    PrintS(Status + 8 * VramStep, "HI-SCORE");
    PrintS(Status + 18 * VramStep, "STAGE");
    PrintByteNumber2(Status + VramRowSize + 20 * VramStep, CurrentStage + 1);
    PrintScore();
    PrintRemain();
}

void PrintScore()
{
    ptr<byte> pVram;
    
    pVram = PrintNumber5(Status + VramRowSize, Score);
    PrintC(pVram, '0');

    pVram = PrintNumber5(Status + VramRowSize + 9 * VramStep, HiScore);
    PrintC(pVram, '0');
}

void PrintRemain()
{
    ptr<byte> pVram;
    pVram = Status + 25 * VramStep;
    if (RemainCount > 1) {
        byte i;
        i = RemainCount - 1;
        if (i > 2) {
            pVram = Put2C(pVram, Char_Remain);
            pVram = Put(pVram, Char_Space);
            pVram = Put(pVram, Char_Space);
            pVram += VramRowSize - 2 * VramStep;
            pVram = Put(pVram, i + 0x10);
            pVram = Put(pVram, Char_Space);
        }
        else {
            do {
                pVram = Put2C(pVram, Char_Remain);
                --i;
            } while (i != 0);
            Erase2(pVram);
        }
    }
    else {
        Erase2(pVram);           
    }
}

void PrintGameOver()
{
    PrintS(VramBack + VramRowSize * 12 + 11 * VramStep, "GAME OVER");
}

void Title()
{
    static const byte[] TitleBytes = {
        //	G
        0x40, 0x4e, 0x45, 0x4b, 
        0x4c, 0x43, 0x4a, 0x4a, 
        0x44, 0x4b, 0x40, 0x4f, 
        0x40, 0x44, 0x45, 0x45, 
        //	U
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x4c, 0x43, 0x40, 0x4f, 
        0x40, 0x45, 0x45, 0x41, 
        //	N
        0x4c, 0x4b, 0x40, 0x4f, 
        0x4c, 0x4f, 0x4b, 0x4f, 
        0x4c, 0x43, 0x4d, 0x4f, 
        0x44, 0x41, 0x40, 0x45, 
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
    ClearScreen(); 
    HideAllSprites();
    // UpdateSprites();
    PrintStatus();
    {
        ptr<byte> p;
        ptr<byte> pVram;
        pVram = VramBack + VramRowSize * 7 + (32 - 4 * 6) / 2 * VramStep;
        p = TitleBytes;
        repeat (6) {
            repeat (4) {
                repeat (4) {
                    pVram = Put(pVram, *p);
                    ++p;
                }
                pVram += VramRowSize - 4 * VramStep;
            }
            pVram += 4 * VramStep - VramRowSize * 4;
        }
    }
    PrintS(VramBack + VramRowSize * 20 + 7 * VramStep, "PUSH START BUTTON");
    PrintS(VramBack + VramRowSize * 23 + 19 * VramStep, "INUFUTO 2025");
    // {
    //     ptr<byte> pVram;
    //     byte c;
    //     pVram = VramBack + VramRowSize * 2;
    //     c = 0;
    //     repeat (0) {
    //         pVram = Put(pVram, c);
    //         ++c;
    //         if ((c & 0x0f) == 0) {
    //             pVram += VramRowSize - 16 * VramStep;
    //         }
    //     }
    // }
}


void AddScore(word pts)
{
    Score += pts;
    if (Score > HiScore) {
        HiScore = Score;
    }
    PrintScore();
}
